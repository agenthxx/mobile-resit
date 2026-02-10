//
//  QuestionViewController.swift
//  personality
//
//  Created by BP-36-201-19 on 08/02/2026.
//

import UIKit

class QuestionViewController: UIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var singleStackView: UIStackView!
    @IBOutlet weak var multipleStackView: UIStackView!
    @IBOutlet weak var multiSubmitButton: UIButton!
    @IBOutlet weak var rangedStackView: UIStackView!
    @IBOutlet weak var rangedLabel1: UILabel!
    @IBOutlet weak var rangedLabel2: UILabel!
    @IBOutlet weak var rangedSlider: UISlider!
    @IBOutlet weak var questionProgressView: UIProgressView!
    @IBOutlet weak var timerLabel: UILabel!
    
    var timer: Timer?
    let timePerQuestion: Int = 10
    var timeRemaining: Int = 10

    var questionIndex = 0
    var quizTitle = ""
    var answerChosen: [Answer] = []
    var questions: [Question] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        guard !questions.isEmpty else { return }
        
        // Shuffle questions
        questions.shuffle()
        
        // Shuffle answers for single/multiple questions only
        for i in 0..<questions.count {
            if questions[i].type != .ranged {
                questions[i].answers.shuffle()
            }
        }
        
        updateUI()
    }
    
    // MARK: - Answer Handlers
    
    @objc func singleAnswerButtonPressed(_ sender: UIButton) {
        timer?.invalidate()
        let currentAnswers = questions[questionIndex].answers
        let selectedIndex = sender.tag
        answerChosen.append(currentAnswers[selectedIndex])
        nextQuestion()
    }
    
    @IBAction func multipleAnswerButtonPressed() {
        timer?.invalidate()
        let currentAnswers = questions[questionIndex].answers
        
        for case let horizontalStack as UIStackView in multipleStackView.arrangedSubviews {
            if let toggle = horizontalStack.arrangedSubviews.compactMap({ $0 as? UISwitch }).first,
               toggle.isOn {
                let index = toggle.tag
                answerChosen.append(currentAnswers[index])
            }
        }
        nextQuestion()
    }
    
    @IBAction func rangedAnswerButtonPressed() {
        timer?.invalidate()
        let currentAnswers = questions[questionIndex].answers
        let index = Int(round(rangedSlider.value * Float(currentAnswers.count - 1)))
        answerChosen.append(currentAnswers[index])
        nextQuestion()
    }
    
    // MARK: - Navigation
    
    func nextQuestion() {
        timer?.invalidate()
        questionIndex += 1
        if questionIndex < questions.count {
            updateUI()
        } else {
            performSegue(withIdentifier: "Results", sender: nil)
        }
    }
    
    @IBSegueAction func showResults(_ coder: NSCoder) -> ResultsViewController? {
        return ResultsViewController(coder: coder, responses: answerChosen, quizTitle: quizTitle)
    }
    
    // MARK: - Update UI
    
    func updateUI() {
        guard questionIndex < questions.count else { return }
        
        // Hide all stacks initially
        singleStackView.isHidden = true
        multipleStackView.isHidden = true
        rangedStackView.isHidden = true
        multiSubmitButton.isHidden = true
        
        let currentQuestion = questions[questionIndex]
        let totalProgress = Float(questionIndex) / Float(questions.count)
        
        navigationItem.title = "Question #\(questionIndex + 1)"
        questionLabel.text = currentQuestion.text
        questionProgressView.setProgress(totalProgress, animated: true)
        
        switch currentQuestion.type {
        case .single:
            updateSingleStack(using: currentQuestion.answers)
        case .multiple:
            updateMultipleStack(using: currentQuestion.answers)
        case .ranged:
            updateRangeStack(using: currentQuestion.answers)
        }
        startTimer()
    }
    
    // MARK: - Dynamic UI Builders
    
    func updateSingleStack(using answers: [Answer]) {
        singleStackView.isHidden = false
        singleStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        for (index, answer) in answers.enumerated() {
            let button = UIButton(type: .system)
            button.setTitle(answer.text, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
            button.tag = index
            button.addTarget(self, action: #selector(singleAnswerButtonPressed(_:)), for: .touchUpInside)
            
            button.backgroundColor = .systemBlue
            button.setTitleColor(.white, for: .normal)
            button.layer.cornerRadius = 8
            button.heightAnchor.constraint(equalToConstant: 44).isActive = true
            
            singleStackView.addArrangedSubview(button)
        }
    }
    
    func updateMultipleStack(using answers: [Answer]) {
        multipleStackView.isHidden = false
        multiSubmitButton.isHidden = false
        multipleStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        for (index, answer) in answers.enumerated() {
            let horizontalStack = UIStackView()
            horizontalStack.axis = .horizontal
            horizontalStack.spacing = 8
            horizontalStack.alignment = .center
            
            let label = UILabel()
            label.text = answer.text
            label.font = UIFont.systemFont(ofSize: 18)
            
            let toggle = UISwitch()
            toggle.tag = index
            
            horizontalStack.addArrangedSubview(label)
            horizontalStack.addArrangedSubview(toggle)
            
            multipleStackView.addArrangedSubview(horizontalStack)
        }
    }
    
    func updateRangeStack(using answers: [Answer]) {
        rangedStackView.isHidden = false
        rangedSlider.setValue(0.5, animated: false)
        rangedLabel1.text = answers.first?.text
        rangedLabel2.text = answers.last?.text
    }
    
    func startTimer() {
        timer?.invalidate()
        timeRemaining = timePerQuestion
        updateTimerLabel()

        timer = Timer.scheduledTimer(
            timeInterval: 1.0,
            target: self,
            selector: #selector(timerTick),
            userInfo: nil,
            repeats: true
        )
    }

    @objc func timerTick() {
        timeRemaining -= 1
        updateTimerLabel()

        if timeRemaining <= 0 {
            timer?.invalidate()
            nextQuestion() // auto move on
        }
    }

    func updateTimerLabel() {
        timerLabel.text = "Time left: \(timeRemaining)s"
    }

}
