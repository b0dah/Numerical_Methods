//
//  main.swift
//  NM_Adams
//
//  Created by Иван Романов on 25/05/2019.
//  Copyright © 2019 Иван Романов. All rights reserved.
//

import Foundation

func f(x: Double, y:Double)-> Double{
    //return 2*pow(x, 3) + 2*y/x // [1;2] n136
    /*-*///return y*y*exp(x) - 2*y // [0:1] n151
    return 5-x*x - y*y + 2*x*y // [0:1] n170
}

let a: Double = 0,
    b: Double = 1, h: Double = 1e-2

let n=Int((b-a)/h + 1);

var x = [Double](repeating: 0.0, count: n),
y = [Double](repeating: 0.0, count: n),
del = [Double](repeating: 0.0, count: n)

x[0] = a
y[0] = 0

for i in 1..<n {
    
    x[i]=a+Double(i)*h;
    
    if (i<=1) {
        y[i]=y[i-1] + h*f(x: x[i-1], y: y[i-1]);
        del[i]=0.0;
    }
    else
    {
        //del[i]=h/24*(55*f(x: x[i-1],y: y[i-1]) - 59*f(x: x[i-2],y: y[i-2])+37*f(x: x[i-3], y: y[i-3])-9*f(x: x[i-4],y: y[i-4]))
        //y[i]=y[i-1]+h/24*(55*f(x: x[i-1],y: y[i-1])-59*f(x: x[i-2],y: y[i-2])+37*f(x: x[i-3], y: y[i-3])-9*f(x: x[i-4], y: y[i-4]))
        
        // *1st* explicit Adams -- initial approx
        y[i] = y[i-1] + h/2 * ( 3 * f(x: x[i-1], y: y[i-1]) - f(x: x[i-2], y: y[i-2]))
        
        // *1st* implicit Adams
        y[i] = y[i-1] + h/2 * ( f(x: x[i], y: y[i]) + f(x: x[i-1],y: y[i-1]))
    }
    //print(i+" "+x[i]+y[i]+" "+del[i]+" "+f(x[i],y[i]) );
    print(y[i])
}

