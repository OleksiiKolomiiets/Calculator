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
    }
    
    @IBOutlet weak var display: UILabel!
    
    private var inTheMiddleOfTyping = false
    var resultValue = 0.0 {
        didSet {
            displayValue = resultValue
        }
    }
    var previousValue = 0.0
    var currentOperation = ""
    var doingSomeOperation = false
    var displayValue: Double {
        get {
            if let displayText = display.text {
                return Double(displayText)!
            } else {
                return self.displayValue
            }
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
    
    @IBAction func performOperationWithTwoOperands(_ sender: UIButton) {
        if let mathematicalSymbol = sender.currentTitle {
            if inTheMiddleOfTyping {
                if doingSomeOperation {
                    resultValue = doOperation(for: resultValue, displayValue, by: currentOperation)
                    doingSomeOperation = false
                } else {
                    resultValue = displayValue
                }
                inTheMiddleOfTyping = false
                doingSomeOperation = true
            }
            currentOperation = mathematicalSymbol
        }
    }
    @IBAction func makeOpposite() {
        if doingSomeOperation {
            if !inTheMiddleOfTyping {
                resultValue = -resultValue
            } else {
                display.text = String(-Double(display.text!)!)
            }
        } else {
            displayValue = -displayValue
        }
    }    

    @IBAction func performOperationWithOneOperand(_ sender: UIButton) {
        if inTheMiddleOfTyping {
            if let operationTitle = sender.currentTitle {
                resultValue = doOperation(for: displayValue, by: operationTitle)
            }
        } else {
            inTheMiddleOfTyping = false
            doingSomeOperation = true
        }
    }
    @IBAction func equalOperation(_ sender: UIButton) {
        if inTheMiddleOfTyping {
            previousValue = displayValue
        }
        if currentOperation == "" {
            resultValue = previousValue
        } else {
            resultValue = doOperation(for: resultValue, previousValue, by: currentOperation)
        }
        inTheMiddleOfTyping = false
        doingSomeOperation = true
    }
    
    private func resetDisplay() {
        inTheMiddleOfTyping = false
        resultValue = 0.0
        previousValue = 0.0
        currentOperation = ""
        doingSomeOperation = false
    }
}

