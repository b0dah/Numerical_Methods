//
//  main.swift
//  comm_line_Simpson
//
//  Created by Иван Романов on 15/03/2019.
//  Copyright © 2019 Иван Романов. All rights reserved.
//

import Foundation

let Eps = 1e-7, a : Double = 0.0, b:Double = 1//3.141592;
var h: Double = (pow(Eps, 0.25))
            //let N : Double = (b-a)/h
            //var numberOfSteps : Int = (Int(round(N)))

/*let a : Double = 0.0, b:Double = 3.1415;
let numberOfSteps = 100
let step = (b-a)/Double(numberOfSteps)
let Eps = pow(step, 4)*/

func f(x: Double)->Double {
   //return cos(x);
    //return x;
    return x*x;
}



func ComputingIntegralValue(step: Double)->Double {
    var summ : Double = 0
    let numberOfSteps = Int(round((b-a)/step))
    
    //numberOfSteps = Int(round(N))
    summ += f(x: a)
    var arg: Double = a + step
    
    for _ in stride(from: 1, to: numberOfSteps-1, by: 2) { // n-2 times
        
        summ += 4*f(x: arg) + 2*f(x: arg+step)
        arg += 2*step
        
    }
    
    //summ += 4*f(x: arg) + f(x: arg + step)
    summ += 4*f(x: b - step) + f(x: b)
    
    summ*=Double(step/3)
    
    //print(N)
    print("STEP = \(step)")
    print(numberOfSteps)
    print("Eps  = \(Eps)")
    print()
    print(summ)
    
    return summ
}

func RungheSchema(h: inout Double){
    while true {
        if ( (16/15)*fabs(ComputingIntegralValue(step: h) - ComputingIntegralValue(step: h/2)) < Eps) {
            print("ok")
            break
        }
        else
            { h /= 2 }
    }
}
///////////////////////////////////
RungheSchema(h: &h)
print("  ANSWER: I = \(ComputingIntegralValue(step: h))")


