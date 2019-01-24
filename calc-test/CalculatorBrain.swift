//
//  CalculatorBrain.swift
//  calc-test
//
//  Created by Nadezda Panchenko on 09/01/2019.
//  Copyright © 2019 Nadezda Panchenko. All rights reserved.
//

import Foundation

class Calculator {
    
    private var operators = [Operator]()
    private var values = [Decimal]()
    
    private var knownOperations = [String : Operator]()
    
    init() {
        knownOperations = ["+": Operator(for: "+", precedence: 1, sign: .add),
                           "−": Operator(for: "−", precedence: 1, sign: .minus),
                           "×": Operator(for: "×", precedence: 4, sign: .multiply),
                           "÷": Operator(for: "÷", precedence: 4, sign: .division),
        ]
    }
    
    func pushOperation(symbol: String) {
        if let new = knownOperations[symbol] {
            operators.append(new)
        }
    }
    
    func pushOperand(newElement: Decimal) {
        values.append(newElement)
    }
    
    func reset() {
        self.operators.removeAll()
        self.values.removeAll()
    }
    
    func calculate(symbol: String) -> Decimal?  {
        var result: Decimal?
        let curOp = knownOperations[symbol]
        if values.count >= 2 {
            if (operators.last?.precedence)! >= curOp!.precedence {
                result = operators.last!.perform(l: values.popLast()!, r: values.popLast()!)
                pushOperand(newElement: result!)
                _ = operators.popLast()
            }
            
        }
//        print(values)
//        print(operators)
//        print("-----------")
        
        return result
    }
    
    func  calculate() -> Decimal? {
        if !operators.isEmpty {
            let currentOperator = operators.popLast()
        }
        return nil
    }
    
    func getTotal() -> Decimal {
        var result:Decimal = 0
        while !operators.isEmpty {
          result = calculate(symbol: operators.last!.value)!
        }
        return result
    }
}
