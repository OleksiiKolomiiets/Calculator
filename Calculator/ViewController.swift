//
//  ViewController.swift
//  Calculator
//
//  Created by Oleksii Kolomiiets on 4/4/18.
//  Copyright © 2018 Oleksii Kolomiiets. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inTheMiddleOfTyping = false
    }
    
    @IBOutlet weak var display: UILabel!
    
    private var inTheMiddleOfTyping: Bool!
    var result = 0.0 {
        didSet {
            displayValue = result
        }
    }
    var previousValue = 0.0
    var operation = ""
    var doingSomeOperation = false
    var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        set {
            display.text = String(newValue)
        }
    }
    
    @IBAction func touchTheButton(_ sender: UIButton) {
        let digit = sender.currentTitle!
        if inTheMiddleOfTyping, display.text != "0" {
            let textCurrentlyInDisplay = display.text!
            let inputedValue = Double(textCurrentlyInDisplay + digit)!
            if isValid(valueForInput: inputedValue) {
                display.text = textCurrentlyInDisplay + digit
            }
        } else if digit != "0" {
            display.text = digit
            inTheMiddleOfTyping = true
        }
    }
    
    @IBAction func clear(_ sender: UIButton) {
        resetDisplay()
    }
    
    @IBAction func performOperation(_ sender: UIButton) {
        if let mathematicalSymbol = sender.currentTitle {
            if inTheMiddleOfTyping {
                inTheMiddleOfTyping = false
                if doingSomeOperation {
                    result = doOperation(for: result, displayValue, by: operation)
                    doingSomeOperation = false
                } else {
                    result = displayValue
                }
                doingSomeOperation = true
            }
            operation = mathematicalSymbol
        }
    }
    
    @IBAction func equalOperation(_ sender: UIButton) {
        if inTheMiddleOfTyping {
            previousValue = displayValue
        }
        if operation == "" {
            result = previousValue
        } else {
            result = doOperation(for: result, previousValue, by: operation)
        }
        inTheMiddleOfTyping = false
        doingSomeOperation = true
        
    }
    
    private func resetDisplay() {
        inTheMiddleOfTyping = false
        result = 0.0
        previousValue = 0.0
        operation = ""
        doingSomeOperation = false
    }
    
}

