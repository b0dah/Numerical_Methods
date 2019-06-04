//
//  main.swift
//  NM_TriDiaginalMatrixAlgorithm
//
//  Created by Иван Романов on 02/06/2019.
//  Copyright © 2019 Иван Романов. All rights reserved.
//

import Foundation

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

let A : [[Double]] =
        [[2,-1,0],
         [5,4,2],
         [0,1,-3]]

let B : [Double] = [3,6,2]

//let instance = TriDiagonalAlgorithm(A: A, B: B)
//print(instance.🍕)


class BoundaryValueProblem {
    
    var 🍔 = [Double]()
    let h: Double = 1e-2, N: Int
    
    var A : [[Double]], B : [Double], x : [Double]
    
    
    init( p: (Double)->Double,
          q: (Double)->Double,
          f: (Double)->Double,
          
          a: Double, b: Double,
          α1️⃣: Double, α2️⃣: Double,
          β1️⃣: Double, β2️⃣: Double ) {
        
        // compute parameters
        N = Int((b-a)/h)
        A = [[Double]](repeating: [Double](repeating: 0.0, count: N+1), count: N+1)
        B = [Double](repeating: 0.0, count: N+1)
        
        x = [Double](repeating: 0.0, count: N+1)
        
        // compute matrix
        A[0][0] = -1 - α1️⃣*h
        A[0][1] = 1
        B[0] = α2️⃣
        
        A[N][N] = 1 - β1️⃣*h
        A[N][N-1] = -1
        B[0] = β2️⃣
        
        
        x[0] = a
        x[N-1] = b
        
        var 👾 = 1
        
        for i in 1...N-1 {
            
            x[👾] = x[👾-1] + h
            
            A[i][i-1] = 1 - p(x[👾])*h/Double(2)
            A[i][i] = -2 + h*h*q(x[👾])
            A[i][i+1] = 1 + p(x[👾])*h/Double(2)
            
            B[i] = h*h*f(x[👾])
            
            👾+=1
        }
        
        // implement TriDiagonal Algorithm
        let TDAInstance = TriDiagonalAlgorithm(A: A, B: B)
        print(TDAInstance.🍕)
        
    }
    
}

func funcP(x: Double) -> Double {
    return 4*x/Double(2*x+1)
}

func funcQ(x: Double)->Double {
    return -4/Double(2*x+1)
}

func funcF(x: Double) -> Double {
    return 0
}

let BVPInstance = BoundaryValueProblem(p: funcP, q: funcQ, f: funcF , a: 0, b: 1, α1️⃣: 1, α2️⃣: 1, β1️⃣: 1, β2️⃣: 3)

//print(BVPInstance.🍔)
