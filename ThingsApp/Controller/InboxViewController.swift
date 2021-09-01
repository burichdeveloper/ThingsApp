//
//  inboxViewController.swift
//  Assignment3
//
//  Created by Rodrigo Dominguez burich on 2021-06-30.
//

import UIKit

class InboxViewController: UIViewController {
    
    var project: Project?
    let todoManager = TodoManager.sharedDataManager
    
    var todos: [TodoItem] = [TodoItem]()
    
    var isDropdownActive = false
    
    
    @IBOutlet weak var todoTableView: UITableView!
    @IBOutlet weak var addButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        todoTableView.delegate = self
        todoTableView.dataSource = self
        addButton.layer.cornerRadius = 25
        todos = todoManager.todos.filter({ TodoItem in
            TodoItem.project == project
        })
        //filter Todo List
        
        //deselect all todos!
        for todo in todos {
            todo.isFocused = false
        }
        
        
        //Register Cells nto tableview
        todoTableView.register(UnselectedTodoViewCell.nib(), forCellReuseIdentifier: "UnselectedTodoViewCell")
        todoTableView.register(TitleCategoryTableViewCell.nib(), forCellReuseIdentifier: "TitleCategoryTableViewCell")
        todoTableView.register(FocusedTodoItemCell.nib(), forCellReuseIdentifier: "FocusedTodoItemCell")
        
    }
    
    @IBAction func dropdownClicked(_ sender: UIButton) {
        if isDropdownActive {
            isDropdownActive = false
            // How to remove a subview from self.view????
            let dropdown = self.children[self.children.count - 1] as! DropdownNavViewController
            dropdown.dismissMenu()
        } else {
            isDropdownActive = true
            
            let popUpVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "DropdownNavViewController") as! DropdownNavViewController
            self.addChild(popUpVC)
            popUpVC.view.frame = self.view.frame
            self.view.addSubview(popUpVC.view)
            popUpVC.didMove(toParent: self)
        }
        
        
        
    }
    
    
    
    @IBAction func addButtonTapped(_ sender: UIButton) {
        for todo in todos {
            todo.isFocused = false
        }
        todoManager.addTodoItem(withProject: project)
        todos = todoManager.todos.filter({ TodoItem in
            TodoItem.project == project
        })
        todoTableView.reloadData()
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


extension InboxViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count + 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TitleCategoryTableViewCell") as! TitleCategoryTableViewCell
            cell.selectionStyle = .none
            cell.configure(imageSysName: "tray.fill", title: project!.projectName!)
            return cell
        } else {
            let todoItem = todos[indexPath.row - 1]
//            print(todoItem)
            if todoItem.isFocused {
                let cell = tableView.dequeueReusableCell(withIdentifier: "FocusedTodoItemCell") as! FocusedTodoItemCell
                cell.todoItem = todoItem
                cell.VCContainer = self
                return cell
            }
            let cell = tableView.dequeueReusableCell(withIdentifier: "UnselectedTodoViewCell") as! UnselectedTodoViewCell
            cell.todoItem = todos[indexPath.row - 1]
            return cell
        }
        
    }

    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var updatedTodoList : [TodoItem] = [TodoItem]()
        if indexPath.row > 0 {
            
            if todos.first(where: { TodoItem in
                TodoItem.isFocused == true}) != nil {
                
                for todo in todos {
                    todo.isFocused = false
                    updatedTodoList.append(todo)
                }
                
            } else {
                
                for todo in todos {
                    todo.isFocused = false
                    updatedTodoList.append(todo)
                }
                
                updatedTodoList[indexPath.row - 1].isFocused = true
                
            }
            
            
            todos = updatedTodoList
            tableView.reloadData()
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let currentCell = cell as? FocusedTodoItemCell {
            currentCell.updateVCLayout()
            print(currentCell.todoItem)
        } else if  let currentCell = cell as? UnselectedTodoViewCell {
            currentCell.updateView()
        }
    }
}
