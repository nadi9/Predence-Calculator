//
//  ViewController.swift
//  calc-test
//
//  Created by Nadezda Panchenko on 09/01/2019.
//  Copyright © 2019 Nadezda Panchenko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var isUserInTheMiddleOfTyping = false
    var userAlreadyPressedDot = false
    var isNumberAlreadyAdded = false
    let calc = Calculator()
    
    @IBOutlet weak var calcDisplay: UILabel!
    
    @IBAction func reset() {
        isUserInTheMiddleOfTyping = false
        displayValue = 0
        calc.reset()
    }
    
    @IBAction func appendDot() {
        if !userAlreadyPressedDot {
            calcDisplay.text! += "."
            userAlreadyPressedDot = true
        }
    }
    
    @IBAction func appendDigit(_ sender: UIButton) {
        isNumberAlreadyAdded = false
        if self.isUserInTheMiddleOfTyping {
            calcDisplay.text! += (sender.titleLabel?.text!)!
        } else {
            calcDisplay.text! = (sender.titleLabel?.text!)!
            isUserInTheMiddleOfTyping = true
        }
    }
    
    var displayValue: Decimal {
        get {
            return NumberFormatter().number(from: calcDisplay.text!)!.decimalValue
        }
        set {
            self.calcDisplay.text = String(describing: newValue)
        }
    }
    
    
    @IBAction func appendOperator(_ sender: UIButton) {
        stopTypingNumber()
        let symbol = sender.titleLabel?.text!
        let  result = calc.calculate(symbol: symbol!)
        calc.pushOperation(symbol: symbol!)
        
        guard let validResult = result else {
            return
        }
        displayValue = validResult
    }
    
    func stopTypingNumber() {
        isUserInTheMiddleOfTyping = false
        userAlreadyPressedDot = false
        
        //protection from adding the number to the stack more than once
        if !isNumberAlreadyAdded {
            calc.pushOperand(newElement: displayValue)
            isNumberAlreadyAdded  = true
        }
    }
    
    
    @IBAction func calculateTotal() {
        stopTypingNumber()
        let validResult = calc.getTotal()
        displayValue = validResult
    }
    
}

