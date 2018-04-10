//
//  CalculatorModel.swift
//  Calculator
//
//  Created by Oleksii Kolomiiets on 4/5/18.
//  Copyright © 2018 Oleksii Kolomiiets. All rights reserved.
//

import Foundation

//enum Operati

struct CalculatorBrain {
    
    private var accumulator: Double?
    
    private enum Operation {
        case twoOperandOperations((Double, Double) -> Double)
        case oneOperandOperations((Double) -> Double)
        case equals
    }
    
    private var operations: Dictionary<String,Operation> = [
        "𝚡²": .oneOperandOperations(getSquareOf),
        "𝚡³": .oneOperandOperations(getCubeOf),
        "𝚎ˣ": .oneOperandOperations(exp),
        "sin": .oneOperandOperations(sin),
        "cos": .oneOperandOperations(cos),
        "tan": .oneOperandOperations(tan),
        "ctan": .oneOperandOperations(tanh),
        "+": .twoOperandOperations(addition),
        "-": .twoOperandOperations(subtraction),
        "*": .twoOperandOperations(multiplication),
        "/": .twoOperandOperations(division),
        "𝚡ʸ": .twoOperandOperations(pow),
        "=": .equals
        
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
    
    func doOperation(_ operation: String, for operand: Double) -> Double {
        var result = 0.0
        switch operation {
        case "𝚡²":
            result = pow(operand, 2)
        case "𝚡³":
            result = pow(operand, 3)
        case "𝚎ˣ":
            result = exp(operand)
        case "sin":
            result = sin(operand*Double.pi/180)
        case "cos":
            result = cos(operand*Double.pi/180)
        case "tan":
            result = tan(operand*Double.pi/180)
        case "ctan":
            result = tanh(operand*Double.pi/180)
        default:
            print("wrong characters: \(operation)")
            break
        }
        return result
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

func isValid(valueForInput value: Double) -> Bool {
    return value < 1000 && value > -1000
}




