//
//  ResultsViewController.swift
//  personality
//
//  Created by BP-36-201-19 on 08/02/2026.
//

import UIKit

class ResultsViewController: UIViewController {
    
    @IBOutlet weak var resultAnswerLabel: UILabel!
    @IBOutlet weak var resultDefinitionLabel: UILabel!
    
    var responses: [Answer]
    var quizTitle: String

    
    init?(coder: NSCoder, responses: [Answer], quizTitle: String) {
        self.responses = responses
        self.quizTitle = quizTitle
        super.init(coder: coder)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "\(quizTitle) Results"
        navigationItem.hidesBackButton = true

        calculatePersonalityResult()
    }

    func calculatePersonalityResult() {
        let frequencyOfAnswers = responses.reduce(into: [PersonalityType:Int]()) { (counts, answer) in
            if let existingCount = counts[answer.type] {
                counts[answer.type] = existingCount + 1
            } else {
                counts[answer.type] = 1
            }
        }
        
        _ = frequencyOfAnswers.sorted(by: { (pair1, pair2) in return pair1.value > pair2.value
        })
        
        let mostCommonAnswer = frequencyOfAnswers.sorted {$0.1 > $1.1}.first!.key
        
        resultAnswerLabel.text = "You are a \(mostCommonAnswer.rawValue)!"
        resultDefinitionLabel.text = mostCommonAnswer.definition
        
        let resultPersonalityQuiz = mostCommonAnswer.rawValue
        let historyItem = QuizHistoryItem(
            quizTitle: quizTitle,
            result: resultPersonalityQuiz,
            date: Date()
        )

        QuizHistoryStore.save(historyItem)
        print("SAVED HISTORY:", QuizHistoryStore.load())
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
