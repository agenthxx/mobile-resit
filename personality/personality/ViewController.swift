//
//  ViewController.swift
//  personality
//
//  Created by BP-36-201-19 on 08/02/2026.
//

import UIKit

class ViewController: UIViewController {

    var selectedQuiz: Quiz?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func animalQuizTApped(_ sender: UIButton) {
        selectedQuiz = animalQuiz
        performSegue(withIdentifier: "StartQuiz", sender: self)
    }
    @IBAction func socialQuizTapped(_ sender: UIButton) {
        selectedQuiz = socialQuiz
        performSegue(withIdentifier: "StartQuiz", sender: self)
    }
    @IBAction func CareerQuizTapped(_ sender: UIButton) {
        selectedQuiz = careerQuiz
        performSegue(withIdentifier: "StartQuiz", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "StartQuiz",
           let quiz = selectedQuiz,
           let questionVC = segue.destination as? QuestionViewController {

            questionVC.questions = quiz.questions
        }
    }

    @IBAction func unwindToQuizIntroduction(segue: UIStoryboardSegue) {
        
    }

}

