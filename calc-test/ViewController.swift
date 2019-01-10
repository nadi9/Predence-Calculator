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
    var isNumberAlreadyAdded = false
    var operands = [Decimal]()
    var operators = [Operator]()
    let calc = Calculator()
    
    @IBOutlet weak var calcDisplay: UILabel!
    
    
    @IBAction func reset() {
        displayValue = 0
        self.operators.removeAll()
        self.operands.removeAll()
    }
    
    
    
    @IBAction func getDigit(_ sender: UIButton) {
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
        
        let plus = Operator(for: "+", precedence: 1, sign: .add)
        let minus = Operator(for: "-", precedence: 1, sign: .minus)
        let multiplication = Operator(for: "*", precedence: 4, sign: .multiply)
        let division = Operator(for: "/", precedence: 4, sign: .division)
        
        switch sender.titleLabel?.text! {
        case "+":
            performOperation(with: plus)
            operators.append(plus)
        case "−":
            performOperation(with: minus)
            operators.append(minus)
        case "×":
            performOperation(with: multiplication)
            operators.append(multiplication)
        case "÷":
            performOperation(with: division)
            operators.append(division)
        default: break
        }
        
       
    }
    
    func performOperation2(operation: String) {
        
    }
    
    func performOperation(with: Operator) {
        setCalculatorValues()
        let result = calc.calculate(with)
        guard let validNumber = result else {
            return
        }
        updateValues(with: validNumber)
        displayValue = validNumber
    }
    
    func updateValues(with newValue: Decimal) {
        _ = self.operands.popLast()
        _ = self.operands.popLast()
        self.operands.append(newValue)
        _ = operators.popLast()
        print(self.operands)
        print(self.operators)
    }
    func setCalculatorValues() {
        calc.operators = self.operators
        calc.values = self.operands
        print(self.operands)
        print(self.operators)
    }
    
    func stopTypingNumber() {
        isUserInTheMiddleOfTyping = false
        //protection from adding the number to the stack more than once
        if !isNumberAlreadyAdded {
            self.operands.append(displayValue)
            isNumberAlreadyAdded  = true
        }
    }
    
    func performAllOperations() {
        while !self.operators.isEmpty {
            performOperation(with: self.operators.last!)
        }
    }
    
    @IBAction func calculateTotal() {
        stopTypingNumber()
        performAllOperations()
    }
    
}

