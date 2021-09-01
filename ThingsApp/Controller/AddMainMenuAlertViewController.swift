//
//  addMainMenuAlertViewController.swift
//  Assignment3
//
//  Created by Rodrigo Dominguez burich on 2021-06-30.
//

import UIKit

class AddMainMenuAlertViewController: UIViewController {

    weak var delegate: AddMainMenuDelegate?
    
    @IBOutlet weak var menuContainerView: UIView!
    @IBOutlet weak var addTodoView: UIStackView!
    @IBOutlet weak var addProject: UIStackView!
    @IBOutlet weak var addAreaView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        menuContainerView.layer.cornerRadius = 10
        
        
        addTodoView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.createToDo)))
        addProject.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.createProject)))
        addAreaView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.createArea)))
        
        menuContainerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: nil))
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.dismissMenu)))
        // Do any additional setup after loading the view.
    }


    @objc func dismissMenu() {
            self.view.removeFromSuperview()
        }
    
    @objc func createToDo() {
            print("add Todo pressed")
        }
    
    @objc func createProject() {
        let alert = UIAlertController(title: "Project title", message: "Please enter an Project Name", preferredStyle: .alert)
        
        alert.addTextField { newProjectTextField in
            //Configue styles of textField
        }
        
        let addAction = UIAlertAction(title: "Add", style: .default) { UIAlertAction in
            let newProjectName = alert.textFields![0] as UITextField
            if newProjectName.text?.count != 0 {
                let pinned = TodoManager.sharedDataManager.areas.first { Area in
                    Area.title == "Pinned"
                }
                TodoManager.sharedDataManager.addProject(title: newProjectName.text!, area: pinned)
                
                self.delegate?.onUpdate()
            }
        }
        alert.addAction(addAction)
        self.present(alert, animated: true, completion: nil)
        self.dismissMenu()
        }
    
    @objc func createArea() {
        let alert = UIAlertController(title: "Area title", message: "Please enter an Area Name", preferredStyle: .alert)
        
        alert.addTextField { newProjectTextField in
            //Configue styles of textField
        }
        
        let addAction = UIAlertAction(title: "Add", style: .default) { UIAlertAction in
            let newAreaName = alert.textFields![0] as UITextField
            if newAreaName.text?.count != 0 {
                TodoManager.sharedDataManager.addArea(title: newAreaName.text!, isOpen: true)
                self.delegate?.onUpdate()
            }
        }
        alert.addAction(addAction)
        self.present(alert, animated: true, completion: nil)
        self.dismissMenu()
        }
    
}
