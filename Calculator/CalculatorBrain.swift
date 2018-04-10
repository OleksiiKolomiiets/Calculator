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
        "𝚡²": .oneOperandOperations({ pow($0, 2) }),
        "𝚡³": .oneOperandOperations({ pow($0, 3) }),
        "𝚎ˣ": .oneOperandOperations(exp),
        "sin": .oneOperandOperations(sin),
        "cos": .oneOperandOperations(cos),
        "tan": .oneOperandOperations(tan),
        "ctan": .oneOperandOperations(tanh),
        "±": .oneOperandOperations({ -$0 }),
        "+": .twoOperandOperations({ $0 + $1 }),
        "-": .twoOperandOperations({ $0 - $1 }),
        "*": .twoOperandOperations({ $0 * $1}),
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

func division(_ a: Double, _ b: Double) -> Double {
    return b != 0.0 ? (a / b) : 0.0
}

func isValid(valueForInput value: Double) -> Bool {
    return value < 1000 && value > -1000
}
