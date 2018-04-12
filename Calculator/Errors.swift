//
//  Errors.swift
//  Calculator
//
//  Created by Oleksii Kolomiiets on 4/11/18.
//  Copyright © 2018 Oleksii Kolomiiets. All rights reserved.
//

import Foundation

enum CalculatorErrors: Error {
    case haveInfinity
    case dividedByZero
    
    var description: String {
        switch self {
        case .haveInfinity:
            return "Error: infinity"
        case .dividedByZero:
            return "Error: divide by zero"
        }
    }
}
