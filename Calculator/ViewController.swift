//
//  ViewController.swift
//  Calculator
//
//  Created by Oleksii Kolomiiets on 4/4/18.
//  Copyright © 2018 Oleksii Kolomiiets. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var displayLabel: UILabel!
    
    private var isInTheMiddleOfTyping = false
    
    var displayValue: Double {
        get {
            if let displayText = displayLabel.text, let doubleValue = Double(displayText) {
                return doubleValue
            } else {
                return 0
            }
        }
        set {
            if !newValue.isFinite {
                displayLabel.text = CalculatorErrors.haveInfinity.description
            } else {
                displayLabel.text = String(newValue)
            }
            
        }
    }
    
    @IBAction func touchTheDigitButton(_ sender: UIButton) {
        let digit = sender.currentTitle!
        if isInTheMiddleOfTyping, displayLabel.text != "0", let textCurrentlyInDisplay = displayLabel.text {
            displayLabel.text = textCurrentlyInDisplay + digit
        } else {
            displayLabel.text = digit
            isInTheMiddleOfTyping = true
        }
    }
      
    private var brain = CalculatorBrain()
    
    private var hasError: Bool = false
    
    @IBAction func performOperation(_ sender: UIButton) {
        if isInTheMiddleOfTyping {
            brain.setOperand(displayValue)
            isInTheMiddleOfTyping = false
        }
        if let mathematicalSymbol = sender.currentTitle, let value = CalculatorBrain.OperationSumbols(rawValue: mathematicalSymbol) {
            do {
                try brain.performOperation(value)
            } catch (let error) {
                hasError = true
                switch error {
                case CalculatorErrors.haveInfinity:
                    displayLabel.text = CalculatorErrors.haveInfinity.description
                case CalculatorErrors.dividedByZero:
                    displayLabel.text = CalculatorErrors.dividedByZero.description
                default:
                    break
                }
            }
        }
        if let result = brain.result, !hasError {
            displayValue = result
        }
        hasError = false
    }
}
