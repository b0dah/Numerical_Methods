//
//  ViewController.swift
//  NM_Simpson's_Formula
//
//  Created by Иван Романов on 13/03/2019.
//  Copyright © 2019 Иван Романов. All rights reserved.
//

import UIKit
import Foundation

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

var Eps = 1e-4
var a : Double = 0.0, b:Double = 1//3.141592;
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
//RungheSchema(h: &h)
//print("  ANSWER: I = \(ComputingIntegralValue(step: h))")
//////////////////////////////////////////////////////////////////////////////
class ViewController: UIViewController {

    @IBOutlet weak var AField: UITextField!
    @IBOutlet weak var BField: UITextField!
    @IBOutlet weak var FormulaField: UILabel!
    @IBOutlet weak var ResultField: UILabel!
    @IBOutlet weak var EpsField: UITextField!
    
    @IBOutlet weak var StepLabel: UILabel!
    
    @IBAction func SolveButton(_ sender: UIButton) {
        /*a = Double(AField.text!) ?? 0
        b = Double(BField.text!) ?? 1
        Eps = Double(EpsField.text!) ?? 1e-4
        StepLabel.text = "Step length  = " + String(h)
    /*computing*/
        RungheSchema(h: &h)
        ResultField.text = "I = " + String(ComputingIntegralValue(step: h))
        
        self.hideKeyboardWhenTappedAround()*/
        
    }
    /*@IBOutlet weak var ResultValueLabel: UILabel!
    
    @IBOutlet weak var ATextField: UITextField!
    @IBOutlet weak var BTextField: UITextField!
    
    @IBOutlet weak var Functionlabel: UILabel!*/
    
    //@IBAction func SolveUIButton(_ sender: UIButton) {
        //Functionlabel.text = 
        
        /*a = Double(ATextField.text!) ?? 0
        b = Double(BTextField.text!) ?? 1
       ResultValueLabel.text = "RESULT = " + String(ComputingIntegralValue(step: h))*/
   // }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.hideKeyboardWhenTappedAround()
    }

   /* override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }*/
    /*func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
      //  self.view.endEditing(true)
        //return false
    }*/
}

