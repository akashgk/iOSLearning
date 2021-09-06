//
//  CalculatorBrain.swift
//  BMI Calculator
//
//  Created by Akash G Krishnan on 06/09/21.
//  Copyright © 2021 Angela Yu. All rights reserved.
//

import Foundation
import UIKit

struct CalculatorBrain {
    var bmi : BMI?
    
    mutating func calculateBmi(height: Float, weight: Float) {
        let bmiValue : Float = weight / (height * height)
        if bmiValue < 18.5{
            bmi = BMI(value: bmiValue, advice: "Eat More", color: #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1))
        } else if bmiValue < 24.9 {
            bmi = BMI(value: bmiValue, advice: "Fit buddy", color: #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1))
        } else{
            bmi = BMI(value: bmiValue, advice: "Eat Less", color: #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1))
        }
    }

    
    func getBmiValue() -> String {
        return String(format : "%.1f", bmi?.value ?? 0.0)
    }
    
    func getColor() -> UIColor {
        return bmi?.color ?? .red
    }
    
    func  getAdvice() -> String {
        return bmi?.advice ?? "Error"
    }
    
}
