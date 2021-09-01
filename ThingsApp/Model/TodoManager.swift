//
//  TodoManager.swift
//  Assignment3
//
//  Created by Rodrigo Dominguez burich on 2021-07-06.
//

import Foundation
import CoreData

class TodoManager {
    
    
    static let sharedDataManager = TodoManager()
    
    var todos: [TodoItem] = []
    var projects: [Project] = []
    var areas: [Area] = []
    var tags: [Tag] = []
    
    
    
    func fetchAllTodos() -> [TodoItem] {
        let request: NSFetchRequest<TodoItem> = TodoItem.fetchRequest()
        guard let results = try? persistentContainer.viewContext.fetch(request)
        else {
            return []
            
        }
        return results.sorted { todoItemA, todoItemB in
            todoItemA.arrayIndex < todoItemB.arrayIndex
        }
    }
    
    func fetchAllProjects() -> [Project] {
        let request: NSFetchRequest<Project> = Project.fetchRequest()
        guard let results = try? persistentContainer.viewContext.fetch(request)
        else {
            return []
            
        }
        return results
    }
    
    func fetchAllAreas() -> [Area] {
        let request: NSFetchRequest<Area> = Area.fetchRequest()
        guard let results = try? persistentContainer.viewContext.fetch(request)
        else {
            return []
            
        }
        return results
    }
    
    func fetchAllTags() -> [Tag] {
        let request: NSFetchRequest<Tag> = Tag.fetchRequest()
        guard let results = try? persistentContainer.viewContext.fetch(request)
        else {
            return []
            
        }
        return results
    }
    
   
    
//    Initializer function
    init () {
        todos = fetchAllTodos()
        projects = fetchAllProjects()
        areas = fetchAllAreas()
        tags = fetchAllTags()
        
        if areas.count == 0  {
            loadInitialData()
        }
    }
    
    
    func loadInitialData() {
        self.addArea(title: "Quick Find", isOpen: true)
        self.addArea(title: "Main", isOpen: true)
        self.addArea(title: "Pinned", isOpen: true)
        
        let mainArea = areas.first { Area in
            Area.title == "Main"
        }
        
        self.addProject(title: "Inbox", area: mainArea)
        self.addProject(title: "Today", area: mainArea)
        self.addProject(title: "Upcoming", area: mainArea)
        self.addProject(title: "Anytime", area: mainArea)
        self.addProject(title: "Someday", area: mainArea)
        self.addProject(title: "Logbook", area: mainArea)
        
    }
    

    func addArea(title: String, isOpen: Bool ) {
        let newArea = Area(context: persistentContainer.viewContext)
        newArea.areaId = UUID().uuidString
        newArea.title = title
        newArea.isOpen = isOpen
        saveContext()
        areas = fetchAllAreas()
    }
    
    func addProject(title: String, area: Area? = nil) {
        let newProject = Project(context: persistentContainer.viewContext)
        newProject.projectId = UUID().uuidString
        newProject.projectName = title
        
        if area != nil {
            newProject.arrayIndex = Int16(area?.projects?.allObjects.count ?? 0)
            newProject.area = area
        }
        
        saveContext()
        projects = fetchAllProjects()
    }
    
    func addTodoItem(withProject project: Project?) {
        assignIndexesTodos()
        let newTodo = TodoItem(context: persistentContainer.viewContext)
        newTodo.todoId = UUID().uuidString
        newTodo.title = "new Todo"
        newTodo.todoDescription = "notes"
        newTodo.project = project
        newTodo.isFocused = true
        newTodo.createdOn = Date()
        newTodo.completed = false
        newTodo.arrayIndex = 0
        saveContext()
        todos = fetchAllTodos()
    }
    
    
    
    func assignIndexesTodos() {
        for todoItem in todos {
            todoItem.arrayIndex += 1
        }
    }
    

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "ThingsDB")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}
