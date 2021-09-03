//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let eggTimes : [String : Int] = [
        "Soft" : 3,
        "Medium" : 8,
        "Hard" : 17
    ]
    
    @IBOutlet weak var pageTitle: UILabel!
    
    @IBOutlet weak var progressbar: UIProgressView!
    
    var secondsRemaining = 60
    var timer = Timer()
     
    
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        timer.invalidate()
        progressbar.progress = 0.0
        let hardness = sender.currentTitle!;
        secondsRemaining = eggTimes[hardness]!

        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil,  repeats: true)
    }
    
    @objc func updateTimer(){
        if(secondsRemaining > 0){
            secondsRemaining -= 1
            pageTitle.text = "\(secondsRemaining)"
        } else{
            timer.invalidate()
            progressbar.progress = 1.0
            pageTitle.text = "Done!"
        }
    }
    
}
