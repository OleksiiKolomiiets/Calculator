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
    var resultValue = 0.0 {
        didSet {
            displayValue = resultValue // TODO: replace
        }
    }
    var previousValue = 0.0
    var currentOperation = "" // TODO: enum?
    var isDoingSomeOperation = false
    
    var displayValue: Double {
        get {
            if let displayText = displayLabel.text, let doubleValue = Double(displayText) {
                return doubleValue
            } else {
                return 0
            }
        }
        set {
            displayLabel.text = String(newValue)
        }
    }
    
    @IBAction func touchTheDigitButton(_ sender: UIButton) {
        let digit = sender.currentTitle!
        if isInTheMiddleOfTyping, displayLabel.text != "0", let textCurrentlyInDisplay = displayLabel.text, let inputedValue = Double(textCurrentlyInDisplay + digit) {
            if isValid(valueForInput: inputedValue) {
                displayLabel.text = textCurrentlyInDisplay + digit
            }
        } else {
            displayLabel.text = digit
            isInTheMiddleOfTyping = true
        }
    }
    
    @IBAction func clear(_ sender: UIButton) {
        resetDisplay()
    }
    
    private var brain = CalculatorBrain()
    
    @IBAction func performOperation(_ sender: UIButton) {
        if isInTheMiddleOfTyping {
            brain.setOperand(displayValue)
            isInTheMiddleOfTyping = false
        }
        if let mathematicalSymbol = sender.currentTitle {
            brain.performOperation(mathematicalSymbol)
        }
        if let result = brain.result {
            displayValue = result
        }
    }
    
    @IBAction func makeOpposite() {
        displayValue = -displayValue
        isInTheMiddleOfTyping = false
    }
    
    private func resetDisplay() {
        isInTheMiddleOfTyping = false
        resultValue = 0.0
        previousValue = 0.0
        currentOperation = ""
        isDoingSomeOperation = false
    }
}

