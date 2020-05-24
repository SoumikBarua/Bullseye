//
//  ViewController.swift
//  Bullseye
//
//  Created by SB on 5/21/20.
//  Copyright © 2020 SB. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var currentValue: Int = 0
    @IBOutlet weak var slider: UISlider!
    var targetValue = 0
    @IBOutlet weak var targetLabel: UILabel!
    var totalScore = 0
    @IBOutlet weak var scoreLabel: UILabel!
    var totalRounds = 0
    @IBOutlet weak var roundsLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        startNewRound()
    }

    @IBAction func showAlert() {
        let difference = abs(targetValue - currentValue)
        let points = 100 - difference
        
        totalScore += points
        
        let message = "You scored \(points) points!"
        
        //let message = "The value of the slider is \(currentValue)" + "\nThe target value is \(targetValue)"
        
        let alert = UIAlertController(title: "Hey, user", message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
        startNewRound()
    }
    
    @IBAction func sliderMoved(_ slider: UISlider){
        currentValue = lroundf(slider.value)
    }
    
    
    // This starts a new round with a new random target number
    func startNewRound() {
        targetValue = Int.random(in: 1...100)
        currentValue = 50
        slider.value = Float(currentValue)
        totalRounds += 1
        updateLabels()
    }
    
    func updateLabels() {
        targetLabel.text = String(targetValue)
        scoreLabel.text = String(totalScore)
        roundsLabel.text = String(totalRounds)
    }
    
}

