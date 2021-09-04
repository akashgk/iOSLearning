//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation
var player: AVAudioPlayer!

class ViewController: UIViewController {
    let eggTimes : [String : Int] = [
        "Soft" : 3,
        "Medium" : 8,
        "Hard" : 17
    ]
    
    @IBOutlet weak var pageTitle: UILabel!
    
    @IBOutlet weak var progressbar: UIProgressView!
    
    var secondsPassed = 0
    var totalTime = 0
    var timer = Timer()
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        timer.invalidate()
        progressbar.progress = 0.0
        let hardness = sender.currentTitle!;
        totalTime = eggTimes[hardness]!
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil,  repeats: true)
    }
    
    @objc func updateTimer(){
        if(secondsPassed < totalTime){
            pageTitle.text = "\(totalTime - secondsPassed)"
            secondsPassed += 1
            let progressPercent = Float(secondsPassed) / Float(totalTime)
            progressbar.progress = progressPercent
        } else{
            timer.invalidate()
            pageTitle.text = "Done!"
            secondsPassed = 0
            totalTime = 0
            playAlarmSound()
        }
    }
    
    func playAlarmSound() {
        guard let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3") else { return }
        
        do {
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            player!.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
}
