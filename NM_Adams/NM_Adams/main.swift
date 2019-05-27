//
//  main.swift
//  NM_Adams
//
//  Created by Иван Романов on 25/05/2019.
//  Copyright © 2019 Иван Романов. All rights reserved.
//

import Foundation

func f(x: Double, y:Double)-> Double{
    return 2*pow(x, 3) + 2*y/x
}

let a: Double = 1,
    b: Double = 2, h: Double = 1e-2

let n=Int((b-a)/h+1);

var x = [Double](repeating: 0.0, count: n),
y = [Double](repeating: 0.0, count: n),
del = [Double](repeating: 0.0, count: n)

x[0] = a
y[0] = 1

for i in 1..<n {
    
    x[i]=a+Double(i)*h;
    
    if (i<=3) {
        y[i]=y[i-1] + h*f(x: x[i-1], y: y[i-1]);
        del[i]=0.0;
    }
    else
    {
        del[i]=h/24*(55*f(x: x[i-1],y: y[i-1])-59*f(x: x[i-2],y: y[i-2])+37*f(x: x[i-3], y: y[i-3])-9*f(x: x[i-4],y: y[i-4]));
        y[i]=y[i-1]+h/24*(55*f(x: x[i-1],y: y[i-1])-59*f(x: x[i-2],y: y[i-2])+37*f(x: x[i-3], y: y[i-3])-9*f(x: x[i-4], y: y[i-4]));
    }
    //print(i+" "+x[i]+y[i]+" "+del[i]+" "+f(x[i],y[i]) );
    print(y[i])
}

