//
//  ViewController.swift
//  Calculator
//
//  Created by Angela Yu on 10/09/2019.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var displayLabel: UILabel!
    private var isFinishedTypingNumber : Bool = true
    private var displayValue : Double {
        get {

            guard  let number = Double(displayLabel.text!)  else {
                fatalError()
            }
            return number
        }
        
        set {
            displayLabel.text = String(newValue)
        }
    }
    
    @IBAction func calcButtonPressed(_ sender: UIButton) {
        isFinishedTypingNumber = true
        guard let number : Double = Double(displayLabel.text!) else {
            fatalError("Can not convert display label to double")
        }
        
        if let calcMethod = sender.currentTitle {
            switch calcMethod {
            case "+/-":
                displayValue += -1
            case "%":
                displayValue = number / 100
            case "AC":
                displayValue = 0.0
            default:
                displayValue += -1
            }
        }
        
        
    }

    
    @IBAction func numButtonPressed(_ sender: UIButton) {
        if let numValue = sender.currentTitle{
            if isFinishedTypingNumber {
                displayLabel.text = numValue
                isFinishedTypingNumber = false
            } else {
                displayLabel.text! += numValue
            }
        }
        print(sender.currentTitle ?? "")
    }

}

