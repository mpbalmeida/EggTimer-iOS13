//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFAudio

class ViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    let softTime = 5
    let mediumTime = 7
    let hardTime = 12
    
    var timer: Timer!
    var remainingSeconds: Float!
    var selectedTotal: Float!
    var player: AVAudioPlayer!
    
    let eggTimes = ["Soft": 5, "Medium": 7 * 60, "Hard": 12 * 60]
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        progressBar.progress = 0.0
        let hardness = sender.currentTitle!
        titleLabel.text = hardness
        selectedTotal =  Float(eggTimes[hardness]!)
        remainingSeconds = selectedTotal - 1
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    

    @objc func updateTime() {
        progressBar.progress = Float((selectedTotal - remainingSeconds) / selectedTotal)
        if (remainingSeconds == 0) {
            timer.invalidate()
            titleLabel.text = "Done"
            playSound()
            
            return
        }
        
        remainingSeconds -= 1
    }
    
    func playSound(){
             let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
             player = try! AVAudioPlayer(contentsOf: url!)
             player.play()
         }
}
