//
//  Question.swift
//  personality
//
//  Created by BP-36-201-19 on 08/02/2026.
//

import Foundation

struct Question {
    var text: String
    var type: ResponseType
    var answers: [Answer]
}

enum ResponseType {
    case single, multiple, ranged
}

struct Answer {
    var text: String
    var type: AnimalType
}

enum AnimalType: Character {
    case lion = "🦁", cat = "🐱", rabbit = "🐰", turtle = "🐢"
    
    var definition: String {
        switch self {
        case .lion:
            return "You are incredibly outgoing. You surround yourself with the people you love and enjoy activities with your friends."
        case .cat:
            return "Mischievous, yet mild-tempered, you enjoy doing things on your own terms."
        case .rabbit:
            return "You love everything that's soft. You are healthy and full of energy."
        case .turtle:
            return "You are wise beyond your years, and you focus on the details. Slow and steady wins the race."
        }
    }
}

var questions: [Question] = [
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
        Answer(text: "I spend most of my weekends relaxing at home.", type: .turtle),
        Answer(text: "I like to go out and explore new places.", type: .rabbit),
        Answer(text: "I enjoy spending time with my friends and family.", type: .cat),
        Answer(text: "I like to do something active and exciting.", type: .lion)
    ])
]
