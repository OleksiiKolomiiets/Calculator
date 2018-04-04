//
//  ViewController.swift
//  Calculator
//
//  Created by Oleksii Kolomiiets on 4/4/18.
//  Copyright © 2018 Oleksii Kolomiiets. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var display: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inTheMiddleOfTyping = false
    }
    private var inTheMiddleOfTyping: Bool! {
        didSet {
            if inTheMiddleOfTyping {
                display.backgroundColor =  #colorLiteral(red: 0.9686274529, green: 0.9385686198, blue: 0.5984157131, alpha: 0.5273169949)
                display.textColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
            } else {
                display.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
                display.textColor = #colorLiteral(red: 0.370555222, green: 0.3705646992, blue: 0.3705595732, alpha: 1)
            }
        }
    }
    
    
    private func resetDisplay() {
        inTheMiddleOfTyping = false
        display.text = "0"
        result = 0.0
        operation = ""
        doingSomeOperation = false
    }
    
    @IBAction func touchTheButton(_ sender: UIButton) {
        let digit = sender.currentTitle!
        if inTheMiddleOfTyping, display.text != "0" {
            let textCurrentlyInDisplay = display.text!
            display.text = textCurrentlyInDisplay + digit
        } else if digit != "0" {
            display.text = digit
            inTheMiddleOfTyping = true
        }
    }
    
    @IBAction func clear(_ sender: UIButton) {
        resetDisplay()
    }
    
    var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        set {
            display.text = String(newValue)
        }
    }
    
    var result = 0.0 
    var operation = ""
    var doingSomeOperation = false
    
    @IBAction func performOperation(_ sender: UIButton) {
        inTheMiddleOfTyping = false
        if let mathematicalSymbol = sender.currentTitle {
            switch mathematicalSymbol {
            case "=":
                doingSomeOperation = false
                displayValue = doOperation(for: result, displayValue, by: operation)
            default:
                if doingSomeOperation {
                    result = doOperation(for: result, displayValue, by: operation)
                    doingSomeOperation = false
                    displayValue = result
                } else {
                    result = displayValue
                }
                operation = mathematicalSymbol
                doingSomeOperation = true
            }
        }
    }
    
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
            result = firstOperand / secondOperand
        default:
            break
        }
        return result
    }
}

