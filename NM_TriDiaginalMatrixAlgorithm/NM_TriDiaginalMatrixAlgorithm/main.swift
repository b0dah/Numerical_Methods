//
//  main.swift
//  NM_TriDiaginalMatrixAlgorithm
//
//  Created by Иван Романов on 02/06/2019.
//  Copyright © 2019 Иван Романов. All rights reserved.
//

import Foundation

let A : [[Double]] =
[[2,-1,0],
 [5,4,2],
 [0,1,-3]]

let B : [Double] = [3,6,2]

class TriDiagonalAlgorithm {
    
    var 🍕 : [Double]
    
    init(A: [[Double]], B: [Double]) {
        var  y = [Double](repeating: 0.0, count: B.count), α = [Double](repeating: 0.0, count: B.count), β = [Double](repeating: 0.0, count: B.count)
        
        let n = B.count - 1
        
        // ==>
        y[0] = A[0][0]
        α[0] = -A[0][1]/y[0]
        β[0] = B[0]/y[0]
        
        for i in 1...n-1 {
            y[i] = A[i][i] + A[i][i-1] * α[i-1]
            α[i] = -A[i][i+1] / y[i]
            β[i] =  (B[i] - A[i][i-1] * β[i-1] ) / y[i]
        }
        
        y[n] = A[n][n] + A[n][n-1] * α[n-1]
        β[n] =  (B[n] - A[n][n-1] * β[n-1]) / y[n]
        
        // <==
        🍕 = [Double](repeating: 0.0, count: B.count)
        
        🍕[n] = β[n]
        
        for i in stride(from: n-1, to: -1/*not incl*/, by: -1) {
          🍕[i] = α[i] * 🍕[i+1] + β[i]
        }
        
    }
}





class BoundaryValueProblem {
    
    var 🍔 = [Double]()
    let h: Double = 5e-2, N: Int
    
    var A : [[Double]], B : [Double], x : [Double]
    
    
    init( p: (Double)->Double,
          q: (Double)->Double,
          f: (Double)->Double,
          
          a: Double, b: Double,
          α1️⃣: Double, α2️⃣: Double,
          β1️⃣: Double, β2️⃣: Double ) {
        
        // compute parameters
        N = Int((b-a)/h)
        A = [[Double]](repeating: [Double](repeating: 0.0, count: N), count: N)
        B = [Double](repeating: 0.0, count: N)
        
        x = [Double](repeating: 0.0, count: N)
        
        // init
       
        // compute matrix
        A[0][0] = -h - h*h * α1️⃣//-2+h*h*q(x[1])  // *left
        A[0][1] = h//1+p(x[1])*h/Double(2)
        B[0] = h*h * α2️⃣//h*h*f(x[1]) - (1 - p(x[1])*h/Double(2) )//
        
        A[N-1][N-1] = h - h*h * β1️⃣                // *right
        A[N-1][N-2] = -h
        B[0] = h*h * β2️⃣
        
        x[0] = a
        x[N-1] = b
        
        x[1] = a+h
        
        var 👾 = 2
        
        for i in 1...N-2 {
            
            x[👾] = x[👾-1] + h
            
            A[i][i-1] = 1
            A[i][i] = -2 - h*p(x[👾]) + h*h*q(x[👾])
            A[i][i+1] = 1 + h*p(x[👾])
            
            B[i] = h*h*f(x[👾])
            
            👾+=1
        }
        
        // implement TriDiagonal Algorithm
        let TDAInstance = TriDiagonalAlgorithm(A: A, B: B)
        print(TDAInstance.🍕)
        
        //print("matrix = ",A)
        
    }
    
}
///////////
func funcP(x: Double) -> Double {
    return 4*x/Double(2*x+1)
}

func funcQ(x: Double)->Double {
    return -4/Double(2*x+1)
}

func funcF(x: Double) -> Double {
    return 0
}
////////////

////////688////
func P(x: Double) -> Double {
    return -1/Double(x * log(x))
}

func Q(x: Double)->Double {
    return 1/Double(x*x*log(x))
}

func F(x: Double) -> Double {
    return 0
}
////////////////////////////////////

//let instance681 = BoundaryValueProblem(p: funcP, q: funcQ, f: funcF , a: 0.0, b: 1.0, α1️⃣: 1.0, α2️⃣: 1.0, β1️⃣: 1.0, β2️⃣: 3.0)

//let instance688 = BoundaryValueProblem(p: P, q: Q, f: F, a: 1.0, b: 2.0, α1️⃣: 1.0, α2️⃣: 1.0, β1️⃣: 1.0, β2️⃣: 0.0)
//print(BVPInstance.🍔)

/*func ff(x: Double) -> Double {
    return 0
}
func pp(x: Double) -> Double {
    return -x
}
func qq(x: Double) -> Double {
    return -1
}

let bookExampleInstance = BoundaryValueProblem(p: pp, q: qq, f: ff, a: 0, b: 1, α1️⃣: 0, α2️⃣: 0, β1️⃣: -2, β2️⃣: 0)*/

func fff(x: Double) -> Double {
    return 0
}
func ppp(x: Double) -> Double {
    return -(2*x+1)/x
}
func qqq(x: Double) -> Double {
    return (x+1)/x
}

//let ex = BoundaryValueProblem(p: ppp, q: qqq, f: fff, a: 0.0, b: 1.0, α1️⃣: 2.0, α2️⃣: 1.0, β1️⃣: 1.0, β2️⃣: 1.0)

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

let ex688 = 🤯(a: 1, b: 2, k1: -1, k2: 1, a1: 1, l1: -1, l2: 1, b1: 0, p: P, q: Q, f: F)
print(ex688.u)


//{Функция коэффициентов при 1-й производной u'(t)}
func p(t:Double)-> Double {
    return -1;
}

// {Функция коэффициентов при u(t)}
func q(t:Double) -> Double {
    return 2/t;
}

// {Функция правой части уравнения}
func f(t:Double)-> Double {
    return t+0.4
}

//let new  =  🤯(a: 1.1, b: 1.4, k1: 1, k2: -2, a1: -1, l1: 1, l2: 0, b1: 4, p: p, q: q, f: f)
//print(new.u)

/**/ //let new = 🤯(a: 0, b: 1, k1: -1, k2: 1, a1: 1, l1: -1, l2: 1, b1: 3, p: funcP, q: funcQ, f: funcF)
//print(new.u)
