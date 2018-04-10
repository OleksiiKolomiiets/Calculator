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
    
    enum OperationSumbols: String {
        case square = "𝚡²"
        case cube = "𝚡³"
        case exp = "𝚎ˣ"
        case sin = "sin"
        case cos = "cos"
        case tan = "tan"
        case ctan = "ctan"
        case opposite = "±"
        case plus = "+"
        case minus = "-"
        case multiply = "*"
        case division = "/"
        case pow = "𝚡ʸ"
        case equals = "="
        case clear = "c"
    }
    
    private var operations: Dictionary<OperationSumbols,Operation> = [
        .square: .oneOperandOperations({ pow($0, 2) }),
        .cube: .oneOperandOperations({ pow($0, 3) }),
        .exp: .oneOperandOperations(exp),
        .sin: .oneOperandOperations(sin),
        .cos: .oneOperandOperations(cos),
        .tan: .oneOperandOperations(tan),
        .ctan: .oneOperandOperations(tanh),
        .opposite: .oneOperandOperations({ -$0 }),
        .plus: .twoOperandOperations({ $0 + $1 }),
        .minus: .twoOperandOperations({ $0 - $1 }),
        .multiply: .twoOperandOperations({ $0 * $1 }),
        .division: .twoOperandOperations(division),
        .pow: .twoOperandOperations(pow),
        .equals: .equals,
        .clear: .clear
    ]
    
    mutating func performOperation(_ symbol: OperationSumbols) {
        if let operation = operations[symbol] {
            switch operation {
            case .oneOperandOperations(let function):
                if accumulator != nil {
                    accumulator = function(accumulator!)
                }
            case .twoOperandOperations(let function):
                if accumulator != nil {
                    pendingForTwoOperandOperations = PendingForTowOperandOperations(function:  function, firstOperand: accumulator!)
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
    return b != 0.0 ? (a / b) : 0.0 // ToDo: Error
}

func isValid(valueForInput value: Double) -> Bool {
    return value < 1000 && value > -1000
}
