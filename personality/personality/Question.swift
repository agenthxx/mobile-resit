//
//  Question.swift
//  personality
//
//  Created by BP-36-201-19 on 08/02/2026.
//

import Foundation

// MARK: - Question Model
struct Question {
    var text: String
    var type: ResponseType
    var answers: [Answer]
}

// MARK: - Response Type
enum ResponseType {
    case single, multiple, ranged
}

// MARK: - Answer Model
struct Answer {
    var text: String
    var type: PersonalityType  // generic type now
}

// MARK: - Personality Types (works for animals, social, career, etc.)
enum PersonalityType: String {
    // Animal quiz
    case lion = "🦁"
    case cat = "🐱"
    case rabbit = "🐰"
    case turtle = "🐢"
    
    // Social quiz
    case introvert = "Introvert"
    case extrovert = "Extrovert"
    case ambivert = "Ambivert"
    case empathetic = "Empathetic"
    
    // Career quiz
    case analytical = "Analytical"
    case adventurous = "Adventurous"
    case collaborative = "Collaborative"
    case creative = "Creative"
    
    // MARK: - Definitions
    var definition: String {
        switch self {
        // Animal types
        case .lion:
            return "You are incredibly outgoing. You surround yourself with the people you love and enjoy activities with your friends."
        case .cat:
            return "Mischievous, yet mild-tempered, you enjoy doing things on your own terms."
        case .rabbit:
            return "You love everything that's soft. You are healthy and full of energy."
        case .turtle:
            return "You are wise beyond your years, and you focus on the details. Slow and steady wins the race."
            
        // Social types
        case .introvert:
            return "You enjoy solitude and need quiet time to recharge."
        case .extrovert:
            return "You are energized by being around people and enjoy social activities."
        case .ambivert:
            return "You enjoy a mix of social interaction and alone time."
        case .empathetic:
            return "You are sensitive to others’ feelings and love helping people."
            
        // Career types
        case .analytical:
            return "You approach problems logically and make decisions carefully."
        case .adventurous:
            return "You enjoy challenges and love taking risks in your career."
        case .collaborative:
            return "You work best with teams and value cooperation."
        case .creative:
            return "You thrive in creative environments and love thinking outside the box."
        }
    }
}
