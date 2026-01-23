//
//  Todo.swift
//  ToDoList
//
//  Created by Vaibhav Sultania on 21/01/26.
//

import Foundation
import SwiftData

@MainActor
@Model
class ToDo {
    var item = ""
    var reminderIsOn = false
    var dueDate = Date.now + 60*60*24
    var notes = ""
    var isCompleted = false
    
    init(item: String = "", reminderIsOn: Bool = false, dueDate: Date = Date.now + 60*60*24, notes: String = "", isCompleted: Bool = false) {
        self.item = item
        self.reminderIsOn = reminderIsOn
        self.dueDate = dueDate
        self.notes = notes
        self.isCompleted = isCompleted
    }
}

extension ToDo {
    static var preview: ModelContainer {
        let container = try! ModelContainer(
            for: ToDo.self,
            configurations: ModelConfiguration(isStoredInMemoryOnly: true)
        )
        
        container.mainContext
            .insert(
                ToDo(
                    item: "Create SwiftData Lessons",
                    reminderIsOn: true,
                    dueDate: Date.now+60*60*24,
                    notes: "Now with xcode 26",
                    isCompleted: false
                )
            )
        container.mainContext
            .insert(
                ToDo(
                    item: "Talk to Michael",
                    reminderIsOn: true,
                    dueDate: Date.now+60*60*48,
                    notes: "Discuss project details",
                    isCompleted: false
                )
            )
        container.mainContext
            .insert(
                ToDo(
                    item: "Learn KMP",
                    reminderIsOn: true,
                    dueDate: Date.now+60*60*24,
                    notes: "Kotlin multiplatform",
                    isCompleted: false
                )
            )
        container.mainContext
            .insert(
                ToDo(
                    item: "Prepare Old iPhone for Lily",
                    reminderIsOn: true,
                    dueDate: Date.now+60*60*2,
                    notes: "She gets my old pro",
                    isCompleted: false
                )
            )
        return container
    }
}
