//
//  ViewController.swift
//  BMI
//
//  Created by Kevin Tran on 10/8/16.
//  Copyright © 2016 Kevin Tran. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {

    class func doDiv100(u : Int) -> Double {
        return Double(u) * 0.01
    }
    
    class func doDiv2(u: Int) -> Double {
        return Double(u) * 0.5
    }
    
    // set the variables as optional because we want to declare a variable that is not set, not write random code to avoid error
    var weight : Double?
    var height : Double?
    // bmi is a function of weight and height so we define the variable as below
    var bmi    : Double? {
        // read only variable, so we use set
        get {
            if (weight != nil && height != nil) {
                return weight! / (height! * height!)
            } else {
                return nil
            }
        }
    }
    
    // .map converts the array one by one
    let listOfHeightsInM = Array(140...220).map(ViewController.doDiv100)
    let listOfWeightsInKg = Array(80...240).map(ViewController.doDiv2)
    
    @IBOutlet weak var bmiLabel: UILabel!
    @IBOutlet weak var heightTextLabel: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var heightPickerView: UIPickerView!
    @IBOutlet weak var weightPickerView: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // this function closes the number pad after the first field is entered.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // a function with no arguments, this updates the bmi label
    func updateUI() {
        if let b = self.bmi {
            self.bmiLabel.text = String(format: "%4.1f", b)
        }
    }
    
    /*  this function retrieve the user's input
        for each user input in the ui, it converts each value from string to double
        then it calculates the final bmi
    */
    func textFieldDidEndEditing(_ textField: UITextField) {
        // attempt to return textField.text, if fail it will still return
        guard let txt = textField.text else {
            return
        }
        
        // convert a free text field to a double
        func conv(numString: String) -> Double? {
            let result : Double? = NumberFormatter().number(from: numString)?.doubleValue
            return result
        }
        
        // this test if this works to proceed to the next
        /*if let txt = textField.text {
            switch (textField) {
            case heightTextLabel:
                self.height = conv(numString: txt)
            case weightTextField :
                self.weight = conv(numString: txt)
            default:
                print("Somethign bad happened")
            } // end of switch
        } //end if
        */
        
        switch (textField) {
        case heightTextLabel:
            self.height = conv(numString: txt)
        case weightTextField :
            self.weight = conv(numString: txt)
        default:
            print("Somethign bad happened")
        } // end of switch
        
        updateUI()
    }
    
    // We only want one spinning barrel
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch (pickerView) {
        case heightPickerView:
            return self.listOfHeightsInM.count
        case weightPickerView:
            return self.listOfWeightsInKg.count
        default:
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch (pickerView) {
        case heightPickerView:
            return String(format: "%4.2f", self.listOfHeightsInM[row])
        case weightPickerView:
            return String(format: "%4.1f", self.listOfWeightsInKg[row])
        default:
            return ""
        }
    }
    
    // the values in the barrel picker are now updated
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch (pickerView) {
        case heightPickerView:
            self.height = self.listOfHeightsInM[row]
        case weightPickerView:
            self.weight = self.listOfWeightsInKg[row]
        default:
            break
        }
        
        updateUI()
    }
}

