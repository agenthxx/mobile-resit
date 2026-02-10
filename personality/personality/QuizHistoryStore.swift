//
//  QuizHistoryStore.swift
//  personality
//
//  Created by BP-36-201-18 on 10/02/2026.
//

import Foundation

class QuizHistoryStore {

    private static let key = "quiz_history"

    static func save(_ item: QuizHistoryItem) {
        var history = load()
        history.append(item)

        if let data = try? JSONEncoder().encode(history) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }

    static func load() -> [QuizHistoryItem] {
        guard
            let data = UserDefaults.standard.data(forKey: key),
            let history = try? JSONDecoder().decode([QuizHistoryItem].self, from: data)
        else {
            return []
        }
        return history
    }
}
