//
//  CalculatorBrain.swift
//  calc-test
//
//  Created by Nadezda Panchenko on 09/01/2019.
//  Copyright © 2019 Nadezda Panchenko. All rights reserved.
//

import Foundation

class Calculator {
    
    var operators = [Operator]()
    var values = [Decimal]()

    func calculate(_ curOp: Operator) -> Decimal?  {
        var result: Decimal?
        if values.count >= 2 {
            if (operators.last?.precedence)! >= curOp.precedence {
                result = operators.last!.perform(l: values.popLast()!, r: values.popLast()!)
            } else if (operators.last?.precedence)! == curOp.precedence {
                result = operators.last!.perform(l: values.popLast()!, r: values.popLast()!)
            }
        } else {
            
        }
        return result
    }
}
