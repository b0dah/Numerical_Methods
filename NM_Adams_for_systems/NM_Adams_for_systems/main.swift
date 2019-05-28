//
//  main.swift
//  NM_Adams_for_systems
//
//  Created by Иван Романов on 28/05/2019.
//  Copyright © 2019 Иван Романов. All rights reserved.
//

import Foundation
import Darwin

func f(x: Double, y: [Double]) -> [Double] {
    return [ y[1] + 2*exp(x),
             y[0] + x * x,
            0]
}

let a: Double = 0,
b: Double = 1, h: Double = 1e-2, size = 2

let n=Int((b-a)/h + 1);

var x = [Double](repeating: 0.0, count: n),
y = [[Double]](repeating: [0,0,0], count: n)

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

x[0] = a

//^^initial
y[0] = [1,-2,0]

// Runge-Kutta Meth
for funcNumb in 0..<size {
    y[1][funcNumb] = y[0][funcNumb] + h * f(x: x[0], y: y[0]) [funcNumb];
}

for i in 2..<n {
    
    x[i]=a+Double(i)*h;
    
    for funcNumb in 0..<size {
        
        // explicit Adams
        y[i][funcNumb] = y[i-1][funcNumb] + h/2 * ( 3 * f(x: x[i-1], y: y[i-1])[funcNumb] - f(x: x[i-2], y: y[i-2])[funcNumb] )
    }
    
    for funcNumb in 0..<size {
        
        // implicit Adams
        y[i][funcNumb] = y[i-1][funcNumb] + h/2 * (  f(x: x[i], y: y[i])[funcNumb] + f(x: x[i-1], y: y[i-1])[funcNumb] )
    }
    
    print(y[i])
    
}
