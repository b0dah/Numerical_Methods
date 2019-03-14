//
//  ViewController.swift
//  NM_Simpson's_Formula
//
//  Created by Иван Романов on 13/03/2019.
//  Copyright © 2019 Иван Романов. All rights reserved.
//

import UIKit
import Foundation

let Eps = 1e-9,   a : Double = 0.0, b:Double = 1.0;
let step: Double = (pow(Eps/16, 0.25))
let N : Double = (b-a)/step
var numberOfSteps : Int = 0

func f(x: Double)->Double {
    //return sin(x);
    return x;
}

var summ : Double = 0

func ComputingIntegralValue()->Double {
    
    /*if (round(N) >= N) {
        numberOfSteps=Int(N) // trunc
    }
    else {
        numberOfSteps = Int(round(N)) // round
    }*/
    
    /*if (Int(N) % 2 == 1) {
        numberOfSteps = Int(N)
        print("aaa")
    }*/
    numberOfSteps = Int(round(N))
    summ += f(x: a)
    var arg: Double = a + step
    
    for _ in stride(from: 1, to: numberOfSteps-1, by: 2) { // n-2 times
    
        summ += 4*f(x: arg) + 2*f(x: arg+step)
        arg += 2*step
        
    }
    
    //summ += 4*f(x: arg) + f(x: arg + step)
    summ += 4*f(x: b - step) + f(x: b)
    
    summ*=Double(step/3)
    
    print(step)
    print(numberOfSteps)
    print()
    print(summ)
    
    return summ
}

//////////////////////////////////////////////////////////////////////////////
class ViewController: UIViewController {

    @IBOutlet weak var ResultValueLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ResultValueLabel.text = "RESULT = " + String(ComputingIntegralValue())
        
        // Do any additional setup after loading the view, typically from a nib.
    }


}

