//
//  boundaryValueClass.swift
//  NM_TriDiaginalMatrixAlgorithm
//
//  Created by Иван Романов on 04/06/2019.
//  Copyright © 2019 Иван Романов. All rights reserved.
//

import Foundation

class BoundaryValueClass{
    
    var 🍔 = [Double]()
    let h: Double = 5e-2, N: Int
    
    var A : [[Double]], B : [Double], x : [Double]
    
    
    init( p: (Double)->Double,
          q: (Double)->Double,
          f: (Double)->Double,
          
          a: Double, b: Double,
          k1️⃣: Double, k2️⃣: Double,
          l1️⃣: Double, l2️⃣: Double,
          
          lValue: Double,
          rValue: Double) {
        
        // compute parameters
        N = Int((b-a)/h)
        A = [[Double]](repeating: [Double](repeating: 0.0, count: N), count: N)
        B = [Double](repeating: 0.0, count: N)
        
        x = [Double](repeating: 0.0, count: N)
        
        // init
        
        // compute matrix
        A[0][0] = (k1️⃣ - k2️⃣/h)//-2+h*h*q(x[1])    // *left
        A[0][1] = k2️⃣/h//1+p(x[1])*h/Double(2)
        B[0] = lValue//h*h*f(x[1]) - (1 - p(x[1])*h/Double(2) )//
        
        A[N-1][N-1] = l1️⃣ + l2️⃣/h               // *right
        A[N-1][N-2] = -l2️⃣/h
        B[0] = rValue
        
        x[0] = a
        x[N-1] = b
        
        
        var 👾 = 2
        
        for i in 1...N-2 {
            
            x[👾] = x[👾-1] + h
            
            A[i][i-1] = 1-p(x[👾])*h/Double(2)
            A[i][i] =   2 - q(x[👾])*h*h
            A[i][i+1] = 1 + p(x[👾])*h/Double(2)
            
            B[i] = h*h*f(x[👾])
            
            👾+=1
        }
        
        // implement TriDiagonal Algorithm
        let TDAInstance = TriDiagonalAlgorithm(A: A, B: B)
        print(TDAInstance.🍕)
        
        print("matrix = ",A)
        
    }
    
}

class 🤯 {
    let n=50// {Число точек}
    let h: Double
    
    var α : [Double], β: [Double],
    t: [Double], u: [Double],
    A : [Double], B : [Double], C: [Double], F: [Double]
    
    init(a: Double,  //{Границы интервала}
        b: Double,
        k1: Double, k2: Double, a1: Double,
        l1: Double, l2: Double, b1: Double,
        p: (Double)-> Double,
        q: (Double)-> Double,
        f: (Double)-> Double) {
        
        //{Вычисление шага сетки}
        h=(b-a)/Double(n)
        
        α = [Double](repeating: 0.0, count: n+1)
        β = [Double](repeating: 0.0, count: n+1)
        t = [Double](repeating: 0.0, count: n+1)
        u = [Double](repeating: 0.0, count: n+1)
        A = [Double](repeating: 0.0, count: n+1)
        B = [Double](repeating: 0.0, count: n+1)
        C = [Double](repeating: 0.0, count: n+1)
        F = [Double](repeating: 0.0, count: n+1)
    
    //{Формирование векторов коэффициентов для 3-диагональной СЛАУ}
    for i in 0...n {
        t[i]=a+h * Double(i);
        A[i]=1-p(t[i])*h/2;
        B[i]=1+p(t[i])*h/2;
        C[i]=2-q(t[i])*h*h;
        F[i]=h*h * f(t[i]);
    }
    
        //{Краевое условие при t=a}
    α[1] = k2/(k2-k1*h);
    β[1] = -(a1*h)/(k2-k1*h);
        
    //{Прямой ход метода прогонки}
    for i in 1...n-1 {
        α[i+1] = B[i] / (C[i]-α[i] * A[i]);
        β[i+1] = (A[i] * β[i] - F[i]) / (C[i]-α[i] * A[i]);
    }
    
    //{Решение на правой границе отрезка}
    u[n] = (l2 * β[n]+b1*h) / (l2+h*l1-l2*α[n]);
    
    //{Обратный ход метода прогонки}
    for i in stride(from: n-1, to: -1, by: -1)  {
        u[i] = α[i+1] * u[i+1] + β[i+1];
    
        //{Вывод таблицы и определение макс.погрешности}
        /*print("i =   t[i]    y[i] = ")
        for i in 0...n {
            print( i," ", t[i], " ", u[i])
        }*/
    
    }
        
      
 }
}
