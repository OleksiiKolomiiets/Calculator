//
//  CalculatorModel.swift
//  Calculator
//
//  Created by Oleksii Kolomiiets on 4/5/18.
//  Copyright © 2018 Oleksii Kolomiiets. All rights reserved.
//

import Foundation

struct CalculatorBrain {
    
    private var accumulator: Double?
    
    private enum Operation {
        case twoOperandOperations((Double, Double) -> Double)
        case oneOperandOperations((Double) -> Double)
        case equals
        case clear
    }
    
    private var operations: Dictionary<String,Operation> = [
        "𝚡²": .oneOperandOperations(getSquareOf),
        "𝚡³": .oneOperandOperations(getCubeOf),
        "𝚎ˣ": .oneOperandOperations(exp),
        "sin": .oneOperandOperations(sin),
        "cos": .oneOperandOperations(cos),
        "tan": .oneOperandOperations(tan),
        "ctan": .oneOperandOperations(tanh),
        "±": .oneOperandOperations(changeSign),
        "+": .twoOperandOperations(addition),
        "-": .twoOperandOperations(subtraction),
        "*": .twoOperandOperations(multiplication),
        "/": .twoOperandOperations(division),
        "𝚡ʸ": .twoOperandOperations(pow),
        "=": .equals,
        "c": .clear
    ]
    
    mutating func performOperation(_ symbol: String) {
        if let operation = operations[symbol] {
            switch operation {
            case .oneOperandOperations(let function):
                if accumulator != nil {
                    accumulator = function(accumulator!)
                }
            case .twoOperandOperations(let function):
                if accumulator != nil {
                    pendingForTwoOperandOperations = PendingForTowOperandOperations(function: function, firstOperand: accumulator!)
                    accumulator = nil
                }
            case .equals:
                performHoldingOperandForTowOperandOperations()
            case .clear:
                accumulator = nil
            }
        }
    }
    
    mutating private func performHoldingOperandForTowOperandOperations() {
        if pendingForTwoOperandOperations != nil && accumulator != nil {
            accumulator = pendingForTwoOperandOperations!.perform(with: accumulator!)
            pendingForTwoOperandOperations = nil
        }
    }
    
    private var pendingForTwoOperandOperations: PendingForTowOperandOperations?
    
    private struct PendingForTowOperandOperations {
        let function: (Double, Double) -> Double
        let firstOperand: Double
        func perform(with secondOperand: Double) -> Double {
            return function(firstOperand, secondOperand)
        }
    }
    
    mutating func setOperand(_ operand: Double) {
        accumulator = operand
    }
    
    var result: Double? {
        get {
            return accumulator
        }
    }
}

func getSquareOf(_ operand: Double) -> Double {
    return pow(operand, 2)
}

func getCubeOf(_ operand: Double) -> Double {
    return pow(operand, 3)
}

func addition(_ a: Double, _ b: Double) -> Double {
    return a + b
}

func subtraction(_ a: Double, _ b: Double) -> Double {
    return a - b
}

func multiplication(_ a: Double, _ b: Double) -> Double {
    return a * b
}

func division(_ a: Double, _ b: Double) -> Double {
    if b != 0.0 {
        return a / b
    } else {
        return 0.0
    }
}

func changeSign(_ a: Double) -> Double {
    return -a
}

func isValid(valueForInput value: Double) -> Bool {
    return value < 1000 && value > -1000
}
