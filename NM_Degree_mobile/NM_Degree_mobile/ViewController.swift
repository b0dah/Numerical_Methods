//
//  ViewController.swift
//  NM_Degree_mobile
//
//  Created by Иван Романов on 24/03/2019.
//  Copyright © 2019 Иван Романов. All rights reserved.
//

import UIKit

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

class ViewController: UIViewController {
    
    private let pickerDataSource = [2, 3, 4]
    var matrixSize : Int = 2
    
/////////////
    let height = Int(UIScreen.main.bounds.height)
    let width = Int(UIScreen.main.bounds.width)
    let sideGap = 30.0, upperGap = 160.0, xGap = 15.0, yGap = 20.0
    
    //let cellWidth = (Double(.width) - 2.0*Double(.sideGap) - 3.0*Double(.xGap))/4
    let cellWidth = 67.0
    let cellHeight = 30.0
    
    
//////////////////////////////////////////////
   // drawing the fields
    var textFieldArray = [[UITextField]]() // field Array
    
    
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var sizePickerView: UIPickerView!
    
    @IBAction func solveButton(_ sender: Any) {
        let comp = Computing(size: matrixSize)
               
        for i in 0..<matrixSize {
            for j in 0..<matrixSize {
                comp.A[i][j] = Double(textFieldArray[i][j].text!) ?? 0
            }
        }
        
        //print(comp.A)
       resultLabel.text = "λ = " + String(comp.compute())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.hideKeyboardWhenTappedAround()
        
        /*var txtField: UITextField = UITextField(frame: CGRect(x: 20, y: 20, width: 500.00, height: 30.00));
        self.view.addSubview(txtField)
        txtField.borderStyle = UITextField.BorderStyle.line
        txtField.text = "myString"
        txtField.backgroundColor = .yellow*/
        
        print(width)
        print(height)
        
        sizePickerView.dataSource = self
        sizePickerView.delegate = self
        
    // creating the fields
        var x_offset = sideGap, y_offset = upperGap
        
        textFieldArray = Array(repeating: Array(repeating: UITextField(frame: CGRect(x: 0, y: 0, width: 0, height: 0)), count: 4), count: 4)
        
        for i in 0..<4 {
            x_offset = sideGap
            for j in 0..<4 {
                textFieldArray[i][j] = UITextField(frame: CGRect(x: x_offset, y: y_offset, width: cellWidth, height: cellHeight))
                self.textFieldArray[i][j].keyboardType = UIKeyboardType.numbersAndPunctuation
                self.view.addSubview(textFieldArray[i][j])
                textFieldArray[i][j].borderStyle = UITextField.BorderStyle.roundedRect
                textFieldArray[i][j].text = "0"
                
                if i>1 || j>1 {textFieldArray[i][j].isHidden = true}
                
                //txtField.backgroundColor = .yellow
                x_offset += cellWidth + xGap
            }
            y_offset += cellHeight + yGap
        }
    }

}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerDataSource.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return String(pickerDataSource[row]) + "x" + String(pickerDataSource[row])
    }
//-------------------------------
    // for upper LABEL:
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // pickerDataSource[row]
        sizeLabel.text = "Size = " + String(pickerDataSource[row]) + "x" + String(pickerDataSource[row])
        //-----------------------------------------------------------
        matrixSize = pickerDataSource[row]
        

        
        
        for i in 0..<pickerDataSource[row] {
            for j in 0..<pickerDataSource[row] {
            //name : String =
            //var textField: UITextField = UITextField(frame: CGRect(x: 20, y: 500, width: cellWidth, height: cellHeight));
            textFieldArray[i][j].isHidden = false
            }
        }
        
        for i in 0..<textFieldArray.count {
            for j in 0..<textFieldArray.count {
                if i>row+1 || j>row+1 {textFieldArray[i][j].isHidden = true}
            }
        }
    }
}


