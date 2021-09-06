//
//  ViewController.swift
//  BMI Calculator
//
//  Created by Angela Yu on 21/08/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit

class CalculateViewController: UIViewController {
    
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var heightSlider: UISlider!
    @IBOutlet weak var weightSlider: UISlider!
    
    var bmiValue : String?
    var calculatorBrain : CalculatorBrain = CalculatorBrain()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func weightSliderChange(_ sender: UISlider) {
        weightLabel.text = String(Int(sender.value)) + "Kg"
    }
    
    @IBAction func heightSliderChange(_ sender: UISlider) {
        heightLabel.text = String(format : "%.2f", sender.value) + "m"
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        let height = heightSlider.value
        let weight = weightSlider.value
        calculatorBrain.calculateBmi(height: height, weight: weight)
        
        self.performSegue(withIdentifier: "goToResult", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult" {
            let destinationVC = segue.destination as! ResultViewController
            destinationVC.bmiValue = calculatorBrain.getBmiValue()
            destinationVC.advice = calculatorBrain.getAdvice()
            destinationVC.backgroundColor = calculatorBrain.getColor()
        }
    }
}
