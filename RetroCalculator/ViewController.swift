//
//  ViewController.swift
//  RetroCalculator
//
//  Created by AlexanderN on 30.08.17.
//  Copyright © 2017 AlexanderN. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    var buttonSound: AVAudioPlayer!
    @IBOutlet weak var outletLabel: UILabel!
    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    
    var currentOperation = Operation.Empty
    
    var runningNumber = ""
    var leftValueString = ""
    var rightValueString = ""
    var result = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        outletLabel.text = "0"
        
        let path = Bundle.main.path(forResource: "btn", ofType: "wav") // Why nil? - You have to add the file in "Expand Copy Bundle Resources"
        
        let sonudURL = URL(fileURLWithPath: path!)
                
        
        do {
            try buttonSound = AVAudioPlayer(contentsOf: sonudURL)
            buttonSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func numberPressed(sender: UIButton) {
        playSound()
        
        runningNumber += "\(sender.accessibilityLabel!)"
        outletLabel.text = runningNumber
    }
    
    @IBAction func operationPressed(sender: UIButton) {
        playSound()
        switch sender.accessibilityLabel! {
        case "*":
            processOperation(operation: .Multiply)
        case "/":
            processOperation(operation: .Divide)
        case "+":
            processOperation(operation: .Add)
        case "-":
            processOperation(operation: .Subtract)
        default:
            break
        }
    }
    
    @IBAction func equalPressed(sender: UIButton) {
        playSound()
        processOperation(operation: currentOperation)
    }
    
    
    func playSound() {
        if buttonSound.isPlaying {
            buttonSound.stop()
        }
        
        buttonSound.play()
    }
    
    func processOperation (operation: Operation) {
        if currentOperation != Operation.Empty {
            
            
            if runningNumber != "" {
                rightValueString = runningNumber
                runningNumber = ""
                
                if currentOperation == Operation.Multiply {
                    result = "\(Double(leftValueString)! * Double(rightValueString)!)"
                } else if currentOperation == Operation.Divide {
                    result = "\(Double(leftValueString)! / Double(rightValueString)!)"
                } else if currentOperation == Operation.Add {
                    result = "\(Double(leftValueString)! + Double(rightValueString)!)"
                } else if currentOperation == Operation.Subtract {
                    result = "\(Double(leftValueString)! - Double(rightValueString)!)"
                }
                leftValueString = result
                outletLabel.text = result
            }
            currentOperation = operation
        } else {
            leftValueString = runningNumber
            runningNumber = ""
            currentOperation = operation
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

