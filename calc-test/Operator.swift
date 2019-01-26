//
//  Operator.swift
//  calc-test
//
//  Created by Nadezda Panchenko on 09/01/2019.
//  Copyright © 2019 Nadezda Panchenko. All rights reserved.
//

import Foundation

/**
 custom realization of math operators, designated to use precedence
 */

struct Operator {
    let value: String
    let precedence: Int
    let sign: MainMathOperators
    
    enum MainMathOperators {
        case add
        case multiply
        case minus
        case division
        case squareRoot
    }
    
    init(for value: String, precedence: Int, sign: MainMathOperators) {
        self.value = value
        self.precedence = precedence
        self.sign = sign
    }
    
    func perform(l: Decimal, r: Decimal) -> Decimal {
        switch sign {
        case .add:
            return l + r
        case .minus:
            return r - l
        case .multiply:
            return l * r
        case .division:
            return r / l
        case .squareRoot:
            //sqrt function does not accept decimal as parameter
            let result = sqrt(NSDecimalNumber(decimal: l).doubleValue)
            return Decimal(result)
        }
    }
    
}
