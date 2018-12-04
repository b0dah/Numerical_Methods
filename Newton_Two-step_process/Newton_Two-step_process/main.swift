//
//  main.swift
//  Newton_Two-step_process
//
// (*)print(NSString(format: "%.2f", x))
/*
 print(matrix[0].count)
 print()
 print(matrix)*/

import Foundation

func change_value(n: inout Int){
    n*=10
}

func function(x: Double)->Double{
    //return sin(x)
    return log10(x)
}

var matrix = [[Double]]()
matrix = [[1,2],[3,4]]


// F U N S
func Fx(arg: [Double] )->[Double] {
    var x = arg[0], y=arg[1], z: Double = 0
    if arg.count == 3 {
        z = arg[2] }
    
    //return [x*x - y,  x-y*y]
    
    //return [(x-1)*(x-1) + y*y - 1,  x*x - y]
    
    /*return [sin(x*y*y) + cos(z-1),
            pow((x-2), 3) - y*z + 2,
            8*x + 7*y - z - exp(y*y) - 6 ]
    */
    
    //return [x*x - y - z,
    //        x-y*y - z,
    //        x-y-z*z]
    
    /*+not linear*/// return [(x-1)*(x-1) + cos(5*x*y) - 1 , 2*exp(z-1) + sin(x+1-2*z*z) - 2, x*x+y*y-z] // 1/0/1
    /*linear*///return [x+y-z, x-y+z-2, z-1] // 1/0/1
    /*polinomial*/return [x*x*x - y*y + z, x*x + y*y + z*z - 2, z-1] // 0/-1/1
}

/*double Derivative(double x0, double accuracy){
    double h = accuracy;
    return (sourceFunction(x0 + h) - sourceFunction(x0 - h))/(2*h);
 }*/

/*func Derivative(arg_ind: Int, fun_ind: Int, x0: Double, y0: Double, accuracy: Double)->Double { //******!******//
    var h : Double = accuracy
    
    switch arg_ind{
    case 1: return (Fx(x: x0 + h, y: y0)[fun_ind] - Fx(x: x0 - h, y: y0)[fun_ind])/(2*h);
    case 2: return (Fx(x: x0, y: y0 + h)[fun_ind] - Fx(x: x0 , y: y0 - h)[fun_ind])/(2*h);
    default: (Fx(x: x0 + h, y: y0)[fun_ind] - Fx(x: x0 - h, y: y0)[fun_ind])/(2*h);
}*/

func multiplyMatrixbyVector(matrix: [[Double]], vector: [Double])-> [Double]{
    var res = [Double](repeating: 0, count: vector.count)
    for i in 0..<vector.count {
        //res.append(0)
        res[i] = 0
        for j in 0..<vector.count {
            res[i]+=matrix[i][j]*vector[j]
        }
    }
    return res;
}

func minor(a:[[Double]], ith: Int, jth: Int)->[[Double]]
{
    var minor : [[Double]] = a
    
    if (jth != 2) /// removing column
    {
        for i in 0...2{
            for j in jth...1 {
                minor[i][j] = minor[i][j+1]
            }
        }
    }
    
    if (ith != 2) /// removing row
    {
        for i in ith...1{
            for j in 0...2 {
                minor[i][j] = minor[i+1][j]
            }
        }
    }
    
    minor.remove(at: 2) // rem last row
    
    for i in 0...1{
        minor[i].remove(at: 2) //rem last column
    }
    return minor
}

func Determinant(a:[[Double]])->Double
{
    if a.count == 2 {
        return (a[0][0]*a[1][1] - a[0][1]*a[1][0])
    }
    else if a.count == 3
    {
        var det : Double = 0
        var sign : Double = 1
        for i in 0...2{
            sign = (i == 1) ? -1 : 1
            det += (sign) * (a[0][i]) * (Determinant(a: minor(a: a, ith: 0, jth: i)))
        }
        return det
    }
    else {
        print("Wrong size")
        return 0
    }
}

func InversedMatrix(a:[[Double]]) -> [[Double]]{
    if Determinant(a: a) == 0 {
        print("Det = 0, inversed matrix doesnt exist")
        return [[0,0],[0,0]]
    }
 
    var result = [[Double]]()
    
    if a.count == 2 ///--------- 2 ------------------------------
    {
        result = [[0,0],[0,0]]
        
        for i in 0...1 {
            for j in 0...1 {
                result[i][j] = a[1-j][1-i] // трансп
                if ((i+j) % 2) != 0 { result[i][j] *= -1 } // signs on da odd places
                result[i][j]/=Determinant(a: a); //   1/Det * A
            }
        }
        
    }
    else if a.count == 3
    {
        result = [[0,0,0],[0,0,0],[0,0,0]]
        for i in 0...2 {
            for j in 0...2 {
            result[i][j] = Determinant(a: minor(a: a, ith: j, jth: i)) // transposed
                if ((i+j) % 2) != 0 { result[i][j] *= -1 } // signs on da odd places
            result[i][j]/=Determinant(a: a); //   1/Det * A
            }
        }
    }
    return result
}
    
func Ak(x0: [Double], accuracy: Double = 0.000001)->[[Double]] { //  2x2
    let h : Double = accuracy
    var J : [[Double]]
    
    if x0.count == 2 {
         J = [[0,0], [0,0]]     // 2 DIMS
    
        for fun_ind in 0..<x0.count{
                for arg_ind in 0..<x0.count {
                    switch arg_ind{
                    case 0: J[fun_ind][arg_ind] = (Fx(arg: [x0[0] + h, x0[1]])[fun_ind] - Fx(arg: [x0[0] - h, x0[1] ])[fun_ind])/(2*h);
                    case 1: J[fun_ind][arg_ind] = (Fx(arg: [x0[0], x0[1] + h ])[fun_ind] - Fx(arg: [x0[0], x0[1] - h ])[fun_ind])/(2*h);
                    default: J[fun_ind][arg_ind] = (Fx(arg: [x0[0] + h, x0[1]])[fun_ind] - Fx(arg: [x0[0] - h, x0[1] ])[fun_ind])/(2*h);
                    }
                }
            }
    }
    else {
        J = [[0,0,0], [0,0,0], [0,0,0]]  // 3 DIMS
        
        for fun_ind in 0..<x0.count{
            for arg_ind in 0..<x0.count {
                switch arg_ind{
                case 0: J[fun_ind][arg_ind] = (Fx(arg: [x0[0] + h, x0[1], x0[2] ])[fun_ind] - Fx(arg: [x0[0] - h, x0[1], x0[2]])[fun_ind])/(2*h);
                case 1: J[fun_ind][arg_ind] = (Fx(arg: [x0[0], x0[1] + h, x0[2]])[fun_ind] - Fx(arg: [x0[0], x0[1] - h, x0[2]])[fun_ind])/(2*h);
                case 2: J[fun_ind][arg_ind] = (Fx(arg: [x0[0], x0[1], x0[2] + h])[fun_ind] - Fx(arg: [x0[0], x0[1], x0[2] - h])[fun_ind])/(2*h);
                    
                default: J[fun_ind][arg_ind] = (Fx(arg: [x0[0] + h, x0[1], x0[2] ])[fun_ind] - Fx(arg: [x0[0] - h, x0[1], x0[2]])[fun_ind])/(2*h);
                }
            }
        }
    }
        return InversedMatrix(a: J)
        //return J
}

func vectorSubstraction(v1: [Double], v2: [Double]) -> [Double] {
    var res = [Double]()
    for i in 0..<v1.count{
        res.append(v1[i] - v2[i])
    }
    
    return res
}

func vectorNorm(v: [Double]) -> Double { // infinity-norm of the vector
    var max: Double = fabs(v[0])
    for i in v {
        if fabs(i) > max { max = fabs(i) }
    }
    return max
}

func DoubleStepNewtonProcess(x0: [Double], eps: Double = 0.00001) -> [Double] { // 2X2
    var z = x0 // начальное приближение
    var x = x0
    //var x_previous = [Double](repeatElement(0, count: x0.count))
    var itr = 0
    
    repeat {
        itr+=1
        //x_previous = x
        /*1*/z = vectorSubstraction(v1: x, v2: multiplyMatrixbyVector(matrix: Ak(x0: x), vector: Fx(arg: x)))
        /*2*/x = vectorSubstraction(v1: z, v2: multiplyMatrixbyVector(matrix: Ak(x0: x/* <- x must be here */), vector: Fx(arg: z)))
    }
    while  ( vectorNorm(v: (vectorSubstraction(v1: x, v2: z))) > eps )
    
    print("\(itr) iterations")
    return x
}


//// P R O G R A M
    //print(multiplyMatrixbyVector(matrix: [[1,2],[3,4]], vector: [1,2]))
    //print(InversedMatrix(a: matrix))
    //print(minor(a: [[1,2,3], [4,5,6], [7,8,9]], ith: 1, jth: 1))
    /*print(Determinant(a: [[1,0,0], [0,1,0], [0,0,1]]))
    print(Determinant(a: [[1,2,3], [4,5,6], [7,8,9]]))
    print(Determinant(a: [[2,5,7], [6,3,4], [5,-2,-3]]))
    print(Determinant(a: [[2,5,7], [6,3,4], [5,-2,-3]]))

    print(InversedMatrix(a: [[2,5,7], [6,3,4], [5,-2,-3]]))*/

    //print(Ak(x0: [1,1]))
    //print(Ak(x0: [1,1,1]))


    //print(vectorSubstraction(v1: [1,2,3], v2: [4,5,6]))
    //print(vectorNorm(v: [1, 0, -100, 0.2]))

    print(DoubleStepNewtonProcess(x0: [0.9, 0.2, 0.9]))
    //print(DoubleStepNewtonProcess(x0: [0.3, 0.3]))

