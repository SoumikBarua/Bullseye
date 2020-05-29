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
        startNewGame()
        
        // Assignn graphics to the slider
        let thumbImageNormal = UIImage(named: "SliderThumb-Normal")!
        slider.setThumbImage(thumbImageNormal, for: .normal)
        
        let thumbImageHighlighted = UIImage(named: "SliderThumb-Highlighted")!
        slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        
        let trackLeftImage = UIImage(named: "SliderTrackLeft")!
        let trackLeftResizable = trackLeftImage.resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        
        let trackRightImage = UIImage(named: "SliderTrackRight")!
        let trackRightSizable = trackRightImage.resizableImage(withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightSizable, for: .normal)
        
    }

    @IBAction func showAlert() {
        // Whatever the current value is, determine the distance from the target
        // Assign points based on how close they were
        let difference = abs(targetValue - currentValue)
        var points = 100 - difference
        
        let alertTitle: String
        if difference == 0 {
            alertTitle =  "Perfect!"
            points += 100
        } else if difference == 1 {
            alertTitle = "You were only off by one!"
            points += 50
        } else if difference < 5 {
            alertTitle = "You almost had it!"
        } else if difference < 10 {
            alertTitle = "Pretty good!"
        } else if difference < 15 {
            alertTitle = "Could be better"
        } else if difference < 25 {
            alertTitle = "A little far off"
        } else {
            alertTitle = "Not even close"
        }
        
        totalScore += points
        
        let message = "You scored \(points) points!"
        
        //let message = "The value of the slider is \(currentValue)" + "\nThe target value is \(targetValue)"
        
        // Intiailize a new alert controller
        let alert = UIAlertController(title: alertTitle, message: message, preferredStyle: .alert)
        
        
        // Add the Ok button alert action to the alert controller, and tie the starting of a new
        // round to pressing of the button, otherwise it executes asynchronously
        let action = UIAlertAction(title: "OK", style: .default, handler: { _ in self.startNewRound()})
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func sliderMoved(_ slider: UISlider){
        // Whenever the slider moves, assign the updated slider value
        currentValue = lroundf(slider.value)
    }
    
    
    // This starts a new round with a new random target number
    func startNewRound() {
        targetValue = Int.random(in: 1...100)
        currentValue = 50
        slider.value = Float(currentValue)
        totalRounds += 1
        updateLabels()
        
        // To animate a crossfade when starting a new round
        let transition = CATransition()
        transition.type =  CATransitionType.fade
        transition.duration = 1
        
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        view.layer.add(transition, forKey: nil)
    }
    
    // Update the labels whenever the values update
    func updateLabels() {
        targetLabel.text = String(targetValue)
        scoreLabel.text = String(totalScore)
        roundsLabel.text = String(totalRounds)
    }
    
    
    @IBAction func startNewGame(){
        totalScore = 0
        totalRounds = 0
        startNewRound()
    }
    
}

