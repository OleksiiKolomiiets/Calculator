//
//  CalculatorModel.swift
//  Calculator
//
//  Created by Oleksii Kolomiiets on 4/5/18.
//  Copyright © 2018 Oleksii Kolomiiets. All rights reserved.
//

import Foundation

func doOperation(for firstOperand: Double, _ secondOperand: Double, by operation: String) -> Double {
    var result = 0.0
    switch operation {
    case "+":
        result = firstOperand + secondOperand
    case "-":
        result = firstOperand - secondOperand
    case "*":
        result = firstOperand * secondOperand
    case "/":
        if secondOperand != 0.0 {
            result = firstOperand / secondOperand
        } else {
            result = firstOperand
        }
    default:
        break
    }
    return result
}

func isValid(valueForInput value: Double) -> Bool {
    return value < 1000 && value > -1000
}


