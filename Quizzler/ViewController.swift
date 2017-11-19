//
//  ViewController.swift
//  Quizzler
//
//  Created by Angela Yu on 25/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let questionBank = QuestionBank()
    var pickedAnswer : Bool = false
    var displayedQuestionIndex = 0
    var score: Int = 0
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var progressBar: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextQuestion()
    }
    
    func nextQuestion() {
        
        if displayedQuestionIndex <= 12 {
            questionLabel.text = questionBank.list[displayedQuestionIndex].questionText
            updateUI()
        } else if displayedQuestionIndex == questionBank.list.count {
            showFinishAlert()
        }
    }


    @IBAction func answerPressed(_ sender: AnyObject) {
        
        if sender.tag == 1 {
            pickedAnswer = true
        }
        else {
            pickedAnswer = false
        }
        
        checkAnswer()
        displayedQuestionIndex += 1
        nextQuestion()
  
    }
    
    func checkAnswer() {
        let correctAnswer = questionBank.list[displayedQuestionIndex].answer
        
        if pickedAnswer == correctAnswer {
            ProgressHUD.showSuccess("Correct")
            score += 1
        }
        else {
            ProgressHUD.showError("Wrong!")
        }
    }
    
    func updateUI() {
        scoreLabel.text = "Score: \(score)"
        progressLabel.text = "\(displayedQuestionIndex + 1)/13"
        progressBar.frame.size.width = (self.view.frame.size.width / 13) * CGFloat((displayedQuestionIndex + 1))
      
    }
    
    func showFinishAlert() {
        let alertController = UIAlertController(title: "Awesome", message: "You have finished quize, do you want to start over", preferredStyle: .alert)
        let restartAction = UIAlertAction(title: "Restart", style: .default, handler: { (UIAlerAction) in
            self.startOver()
        })
        
        alertController.addAction(restartAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func startOver() {
       displayedQuestionIndex = 0
       score = 0
       nextQuestion()
       
    }

}
