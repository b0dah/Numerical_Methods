//
//  ComputingModel.swift
//  NM_Degree_mobile
//
//  Created by Иван Романов on 24/03/2019.
//  Copyright © 2019 Иван Романов. All rights reserved.
//

import Foundation

class Computing {
    
    var A : [[Double]]
    
    var n=0, ε = 1e-8, δ = 1e-12
    var y : [Double],// = Array(repeating: 5, count: n),
    λ: [(Double, Bool)], //= Array(repeating: (1.0 ,false), count: n),
    λ_prev: [(Double, Bool)] //= Array(repeating: (1.0, false), count: n)
    var x: [Double],// = y,
    x_prev : [Double]// = nlized_v(a: y)
    var A_cur : [[Double]],//= A,
    degree = 1.0;
    var AccuracyReached = false,
    k = 0

    
    
    func x_rate()->Double {
        var summ = 0.0
        for i in 0..<x.count {
            summ+=fabs(x[i])
        }
        return summ
    }
    
    func normalize_x () {
        //var buff_v = Array(repeating: 0.0, count: a.count)
        let rate = x_rate()
        
        for i in 0..<x.count {
            x[i] /= rate
        }
    }
    
    func matrixA_x_vectorX() {
        //var res : [Double] = Array (repeating: 0, count: x.count)
        
        for i in 0..<x.count {
            for j in 0..<x.count {
                y[i]+=A[i][j]*x[j]
            }
        }
    }
    
    func λ_average() -> Double {
        var summ = 0.0, n = 0
        
        for i in 0..<λ.count{
            if λ[i].1 == true {
                summ+=λ[i].0
                n+=1
            }
        }
        return summ/Double(n)
    }
    
    func squareA() {
        var res = Array(repeating: Array(repeating: 0.0, count: A.count), count: A.count)
        for i in 0..<A.count {
            for j in 0..<A.count {
                for k in 0..<A.count {
                    res[i][j] += A[i][k]*A[k][j]
                }
            }
        }
     
        A = res
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
    
    init(size: Int) {
        self.A = Array(repeating: Array(repeating: 0, count: size), count: size)
        n = size
        
        y = Array(repeating: 5, count: n)
        λ = Array(repeating: (1.0 ,false), count: n)
        λ_prev = Array(repeating: (1.0, false), count: n)
        x = y
        x_prev = y
        A_cur = A
        
    }
 //-====-=-==-=-=-=-=-=009==0-==-=-=-=-=-=-=-=-=------===-=-=-=-==-=-=
    func compute() -> Double {
        print("x = \(x)")
        normalize_x()
        print("x = \(x)")
        
        while true {
            k+=1
                    
            matrixA_x_vectorX()
            x=y
            normalize_x()
            
            squareA()
            /*4*/
            //if (k>0) {
            
            for i in 0..<λ.count {
                if fabs(x_prev[i]) >= δ {
                    //λ[i].value = y[i]/x_prev[i] λ[i].good = true
                    λ[i] = (y[i]/x_prev[i], true)
                    λ[i].0 = pow( λ[i].0, degree) //
                }
                
                if ( λ[i].1 == true ) && ( fabs(λ[i].0 - λ_prev[i].0) > ε ) {
                    AccuracyReached = false
                }
            }
            
            //if k>5 {break}
            //}
            
            if AccuracyReached {break} // -->>
            
            x_prev = x
            λ_prev = λ
            degree *= 0.5
            
            AccuracyReached = true
        }
        
        print("Λ = \(λ_average())    x = \(x)") //// ???????????????
        //print("  ANS : Λ = \(returnMinIndElement(a: λ))    x = \(x)")
        print(λ)
        print(k)
        
        return λ_average()
    }
    
    
}
