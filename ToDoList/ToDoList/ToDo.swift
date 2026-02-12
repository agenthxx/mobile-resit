//
//  ToDo.swift
//  ToDoList
//
//  Created by BP-36-201-18 on 12/02/2026.
//

import Foundation

enum ToDoCategory: String, Codable, CaseIterable {
    case work = "Work"
    case personal = "Personal"
    case errands = "Errands"
}

struct ToDo: Equatable,Codable {
    let id: UUID
    var title: String
    var isComplete: Bool
    var dueDate: Date
    var notes: String?
    var category: ToDoCategory
    
    static let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let archiveURL = documentsDirectory.appendingPathComponent("toDos").appendingPathExtension("plist")
    
    init(id: UUID = UUID(),title: String, isComplete: Bool, dueDate: Date, notes: String?, category: ToDoCategory) {
        self.id = id
        self.title = title
        self.isComplete = isComplete
        self.dueDate = dueDate
        self.notes = notes
        self.category = category
    }
    static func == (lhs: ToDo, rhs: ToDo) -> Bool {
        return lhs.id == rhs.id
    }
    
    static func loadToDos() -> [ToDo]? {
        guard let codedToDos = try? Data(contentsOf: archiveURL) else {
            return nil
        }
        let propertyListDecoder = PropertyListDecoder()
        return try? propertyListDecoder.decode(Array<ToDo>.self, from: codedToDos)
    }
    
    static func loadSampleToDos() -> [ToDo] {
        let toDo1 = ToDo(title: "Finish project report",
                         isComplete: false,
                         dueDate: Date().addingTimeInterval(3600 * 24),
                         notes: "Summarize findings and email manager",
                         category: .work)

        let toDo2 = ToDo(title: "Buy groceries",
                         isComplete: false,
                         dueDate: Date().addingTimeInterval(3600 * 48),
                         notes: "Milk, bread, eggs, fruit",
                         category: .personal)

        let toDo3 = ToDo(title: "Gym workout",
                         isComplete: false,
                         dueDate: Date(),
                         notes: "Leg day completed",
                         category: .errands)

        return [toDo1, toDo2, toDo3]
    }

    static func saveToDos(_ toDos: [ToDo]) {
        let propertyListEncoder = PropertyListEncoder()
        let codedToDos = try? propertyListEncoder.encode(toDos)
        try? codedToDos?.write(to: archiveURL, options: .noFileProtection)
    }
}
