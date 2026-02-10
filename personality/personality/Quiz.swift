//
//  Quiz.swift
//  personality
//
//  Created by BP-36-201-18 on 10/02/2026.
//

import Foundation

struct Quiz {
    let questions: [Question]
}

let animalQuiz = Quiz(
    questions: [
        Question(text: "Which food do you like the most?", type: .single, answers: [
            Answer(text: "Steak", type: .lion),
            Answer(text: "Fish", type: .turtle),
            Answer(text: "Eggs", type: .rabbit),
            Answer(text: "Cheese", type: .cat)
        ]),
        Question(text: "Which activities do you enjoy?", type: .multiple, answers: [
            Answer(text: "Swimming", type: .turtle),
            Answer(text: "Hiking", type: .rabbit),
            Answer(text: "Dancing", type: .cat),
            Answer(text: "Cooking", type: .lion)
        ]),
        Question(text: "How do you usually spend your weekends?", type: .ranged, answers: [
            Answer(text: "Relaxing at home", type: .turtle),
            Answer(text: "Exploring places", type: .rabbit),
            Answer(text: "With friends & family", type: .cat),
            Answer(text: "Active & exciting", type: .lion)
        ])
    ]
)

let socialQuiz = Quiz(
    questions: [
        Question(text: "What is your favorite way to spend free time?", type: .single, answers: [
            Answer(text: "Reading a book", type: .introvert),
            Answer(text: "Going to parties", type: .extrovert),
            Answer(text: "Chatting with friends", type: .ambivert),
            Answer(text: "Helping others", type: .empathetic)
        ]),
        Question(text: "Which activities do you enjoy the most?", type: .multiple, answers: [
            Answer(text: "Volunteering", type: .empathetic),
            Answer(text: "Hosting events", type: .extrovert),
            Answer(text: "Studying alone", type: .introvert),
            Answer(text: "Team projects", type: .ambivert)
        ]),
        Question(text: "How do you feel in a large group?", type: .ranged, answers: [
            Answer(text: "Overwhelmed", type: .introvert),
            Answer(text: "Comfortable sometimes", type: .ambivert),
            Answer(text: "Excited & energized", type: .extrovert),
            Answer(text: "I thrive helping others", type: .empathetic)
        ])
    ]
)

let careerQuiz = Quiz(
    questions: [
        Question(text: "Which work environment suits you best?", type: .single, answers: [
            Answer(text: "Quiet office", type: .analytical),
            Answer(text: "Fast-paced startup", type: .adventurous),
            Answer(text: "Team-based projects", type: .collaborative),
            Answer(text: "Flexible & creative", type: .creative)
        ]),
        Question(text: "Which tasks do you enjoy most?", type: .multiple, answers: [
            Answer(text: "Solving problems", type: .analytical),
            Answer(text: "Brainstorming ideas", type: .creative),
            Answer(text: "Leading teams", type: .collaborative),
            Answer(text: "Taking risks", type: .adventurous)
        ]),
        Question(text: "How do you make career decisions?", type: .ranged, answers: [
            Answer(text: "Careful planning", type: .analytical),
            Answer(text: "Following my passion", type: .creative),
            Answer(text: "Seeking advice from colleagues", type: .collaborative),
            Answer(text: "Going with my gut", type: .adventurous)
        ])
    ]
)
