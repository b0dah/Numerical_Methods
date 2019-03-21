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

func v_average(a:[(Double, Bool)]) -> Double {
    var summ = 0.0, n = 0
    
    for i in 0..<a.count{
        if a[i].1 == true {
            summ+=a[i].0
            n+=1
        }
    }
    return summ/Double(n)
}

func m_square(a: [[Double]]) -> [[Double]] {
    <#function body#>
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

let A : [[Double]] = /*+*/ //[[3,1],
                            //[0,2]]
//[[2,-1],
// [-1,2]]

  /*+*/ //[[2,1,0], // ???
        // [1,2,0],
        // [0,0,-5]]
    
    /*+*/ //[[1,2,-1], // +++
          // [3,4,3],
          // [5,6,-5]]
    
  /*+*/ // [[2,1],
        //  [2,3]]

/*+*/ [[2,0,2], //+++
       [0,2,2],
       [2,2,0]]


let n = A.count, ε = 1e-8, δ = 1e-3
var y : [Double] = Array(repeating: 0.1, count: n),
λ = Array(repeating: (0.1,false), count: n),
λ_prev = Array(repeating: (0.1,false), count: n)
//λ = [lambda]() , λ_prev = [lambda]()

//λ.reserveCapacity(n)
//λ_prev.reserveCapacity(n)

var AccuracyReached = false, k = 0
///////////////////////// computing ///////////////

var x: [Double] = y, x_prev : [Double] = nlized_v(a: y)

while true {
    y = matrix_x_vector(a: A, x: x)
    x = nlized_v(a: y)
/*4*/
    //if (k>0) {

        for i in 0..<λ.count {
            if fabs(x_prev[i]) >= δ {
                //λ[i].value = y[i]/x_prev[i] λ[i].good = true
                λ[i] = (y[i]/x_prev[i], true)
            }
            
            if  ( λ[i].1 == true ) && ( fabs(λ[i].0 - λ_prev[i].0) > ε ) {
                AccuracyReached = false
            }
        }
    //}
    
    if AccuracyReached {break} // -->>
    
    x_prev = x
    λ_prev = λ
    
    k+=1
    AccuracyReached = true
}

//print("Λ = \(v_average(a: λ))    x = \(x)") //// ???????????????
print("ANS : Λ = \(returnMinIndElement(a: λ))    x = \(x)")
print(λ)
print(k)
