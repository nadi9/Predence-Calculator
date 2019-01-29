//
//  ViewController.swift
//  calc-test
//
//  Created by Nadezda Panchenko on 09/01/2019.
//  Copyright © 2019 Nadezda Panchenko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    var isUserInTheMiddleOfTyping = false
    var userDidNotEnterDot = false
    var isNumberAlreadyAdded = false
    let calc = Calculator()
    
    @IBOutlet weak var calcDisplay: UILabel!
    
    @IBAction func reset() {
        isUserInTheMiddleOfTyping = false
        displayValue = 0
        calc.reset()
    }
    
    @IBAction func appendDot() {
        isUserInTheMiddleOfTyping = true
        if  !userDidNotEnterDot {
            calcDisplay.text! += "."
            userDidNotEnterDot = true
        }
    }
    
    @IBAction func appendDigit(_ sender: UIButton) {
        isNumberAlreadyAdded = false
        
        if isUserInTheMiddleOfTyping {
            
            if calcDisplay.text! == "0" {
                if !userDidNotEnterDot {
                    calcDisplay.text! = (sender.titleLabel?.text!)!
                } else {
                    calcDisplay.text! += (sender.titleLabel?.text!)!
                }
            } else {
                calcDisplay.text! += (sender.titleLabel?.text!)!
            }
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
            stopTypingNumber()
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
        userDidNotEnterDot = false
        
        //protection from adding the number to the stack more than once
        if !isNumberAlreadyAdded {
            calc.pushOperand(newElement: displayValue)
            isNumberAlreadyAdded  = true
        }
    }
    
    
    @IBAction func calculateTotal() {
        stopTypingNumber()
        guard let validResult = calc.getTotal() else {
            print("error")
            return
        }
        displayValue = validResult
    }
    
}

