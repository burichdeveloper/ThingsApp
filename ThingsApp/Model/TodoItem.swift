//
//  TodoItem.swift
//  Assignment3
//
//  Created by Rodrigo Dominguez burich on 2021-08-09.
//

import Foundation


extension TodoItem {
    
    convenience init(withProject project: Project) {
        self.init(withProject: project)
        self.project = project
        self.todoId = UUID().uuidString
        self.title = "new Todo"
        self.todoDescription = "notes"
        isFocused = true
        createdOn = Date()
        completed = false
        scheluedOn = nil
        deadlineOn = nil
    }
}
