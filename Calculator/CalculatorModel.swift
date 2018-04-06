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
    case "𝚡ʸ":
        result = pow(firstOperand, secondOperand)
    default:
        break
    }
    return result
}

func doOperation(for operand: Double, by operation: String) -> Double {
    var result = 0.0
    switch operation {
    case "𝚡²":
        result = pow(operand, 2)
    case "𝚡³":
        result = pow(operand, 3)
    case "𝚎ˣ":
        result = exp(operand)
    default:
        print("wrong characters: \(operation)")
        break
    }
    return result
}

func isValid(valueForInput value: Double) -> Bool {
    return value < 1000 && value > -1000
}


