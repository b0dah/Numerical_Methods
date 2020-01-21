//
//  main.swift
//  NM_Degree_Method
//
//  Created by Иван Романов on 19/03/2019.
//  Copyright © 2019 Иван Романов. All rights reserved.
//

import Foundation

func v_rate(a: [Double])->Double {
    var summ = 0.0
    for i in 0..<a.count {
        summ+=fabs(a[i])
    }
    return summ
}

func nlized_v (a: [Double])->[Double] {
    var buff_v = Array(repeating: 0.0, count: a.count)
    let rate = v_rate(a: a)
    
    for i in 0..<a.count {
        buff_v[i] = a[i]/rate
    }
    return buff_v
}

func matrix_x_vector(a: [[Double]], x: [Double])->[Double] {
    var res : [Double] = Array (repeating: 0, count: x.count)
    
    for i in 0..<x.count {
        for j in 0..<x.count {
            res[i]+=a[i][j]*x[j]
        }
    }
    return res
}

func v_average(a:[(Double, Bool)], Eps: Double) -> Double {
    var summ = 0.0, n = 0
    var convergence = true;
    var max_abs = fabs(a[0].0)
    
    for i in 0..<a.count{
        for j in 1..<a.count{
            if fabs(a[j].0) > max_abs {max_abs = fabs(a[j].0) }
            if a[i].1 == true && a[j].1 == true {
                if fabs(a[i].0 - a[j].0) > 100*Eps {
                    convergence = false
                }
            }
        }
    }
   
    if convergence {
    for i in 0..<a.count{
        if a[i].1 == true {
            summ+=a[i].0
            n+=1
        }
    }
    return summ/Double(n)
    }
    
    else {return max_abs}
}


func m_square(a: [[Double]]) -> [[Double]] {
    var res = Array(repeating: Array(repeating: 0.0, count: a.count), count: a.count)
    for i in 0..<a.count {
        for j in 0..<a.count {
            for k in 0..<a.count {
                res[i][j] += a[i][k]*a[k][j]
            }
        }
    }
    return res
}

func returnMinIndElement(a: [(Double, Bool)] ) -> Double {
    for i in 0..<a.count{
        if a[i].1 == true {
           return a[i].0
        }
    }
    print("nothing")
    return a[0].0
}
//print(v_rate(a: [1,2,-3]))
//print(matrix_x_vector(a: [[1,1],[1,1]], x: [2,1]))
//print(nlized_v(a: [1,1,1,1]))

////////// DATA /////////////////////////////////////

let A : [[Double]] = /*+*/ [[3,1], //&&
                            [0,2]]

                    //[[1, 0], //&&
                    //[1,-5]]

//[[2,-1],
// [-1,2]]

  /*+*/ //[[2,1,0], // ???
        // [1,2,0],
        // [0,0,-5]]
    
    /*+*/ //[[1,2,-1], // +++
          // [3,4,3],
          // [5,6,-5]]
    
  /*+*/  //[[2,1],
         // [2,3]]

/*+*///[[3,4],
      //[5,3]]

/*+*/ //[[2,0,2], //+++
      // [0,2,2],
      // [2,2,0]]


let n = A.count, ε = 1e-5, δ = 1e-12
var y : [Double] = Array(repeating: 5, count: n),
λ = Array(repeating: (1.0 ,false), count: n),
λ_prev = Array(repeating: (1.0, false), count: n)
//λ = [lambda]() , λ_prev = [lambda]()

//λ.reserveCapacity(n)
//λ_prev.reserveCapacity(n)

var AccuracyReached = false, k = 0
///////////////////////// computing ///////////////

var x: [Double] = y, x_prev : [Double] = nlized_v(a: y)
var A_cur = A, degree = 1.0;

while true {
    k+=1
    //y = matrix_x_vector(a: A, x: x)
    y = matrix_x_vector(a: A_cur, x: x)
    x = nlized_v(a: y)
    
    A_cur = m_square(a: A_cur)
/*4*/
    print("-> ")
    
        for i in 0..<λ.count {
            print("  \(λ[i].0)")
            if fabs(x_prev[i]) >= δ {
                //λ[i].value = y[i]/x_prev[i] λ[i].good = true
                λ[i] = (y[i]/x_prev[i], true)
                λ[i].0 = pow( fabs(λ[i].0), degree) //
            }
            
            if ( λ[i].1 == true ) && ( fabs(λ[i].0 - λ_prev[i].0) > ε ) {
                AccuracyReached = false
            }
        }

    
    if AccuracyReached {break} // -->>
    
    x_prev = x
    λ_prev = λ
    degree *= 0.5
   
    AccuracyReached = true 
}

print("Λ = \(v_average(a: λ, Eps: ε))    x = \(x)") //// ???????????????
//print("  ANS : Λ = \(returnMinIndElement(a: λ))    x = \(x)")
print(λ)
print(k)

//print(" last flag = \(")
