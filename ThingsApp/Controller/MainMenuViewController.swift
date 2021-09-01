//
//  ViewController.swift
//  Assignment3
//
//  Created by Rodrigo Dominguez burich on 2021-06-30.
//

import UIKit

class MainMenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, AddMainMenuDelegate {
    
    func onUpdate() {
        MainMenuTableView.reloadData()
    }
    

    @IBOutlet weak var MainMenuTableView: UITableView!
    @IBOutlet weak var addButtonOutlet: UIButton!
    
    
    let todoManager : TodoManager = TodoManager.sharedDataManager
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        MainMenuTableView.register(MainMenuCategoryTableViewCell.nib(), forCellReuseIdentifier: "MainMenuCategoryTableViewCell")
        MainMenuTableView.register(QuickFindTableViewCell.nib(), forCellReuseIdentifier: "QuickFindTableViewCell")
        
        addButtonOutlet.layer.cornerRadius = 25
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return todoManager.areas.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let area: Area = todoManager.areas[section]
        
        switch section {
        case 0: // Quick find
            return 1
        
        case 1: // Main
            return area.projects != nil ? area.projects!.count : 0
        
        case 2: //Pinned
            return area.projects != nil ? area.projects!.count : 0
                
        
        default:
            if area.isOpen {
                return area.projects != nil ? area.projects!.count + 1 : 1
            }
            else {
                return 1
            }
        }
        
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let area = todoManager.areas[indexPath.section]
        var projects = area.projects?.allObjects as? [Project]
        projects?.sort(by: { A, B in
            A.arrayIndex < B.arrayIndex
        })
        
        
        switch area.title {
        case "Quick Find":
            let cell = tableView.dequeueReusableCell(withIdentifier: "QuickFindTableViewCell") as! QuickFindTableViewCell
            cell.selectionStyle = .none
            return cell

        case "Main":
            let cell = tableView.dequeueReusableCell(withIdentifier: "MainMenuCategoryTableViewCell") as! MainMenuCategoryTableViewCell
            
            cell.configue(with: projects?[indexPath.row].projectName ?? "failed")
//            Draw a line and the end of this section
            if indexPath.row == (projects?.count ?? 1) - 1 {
                cell.bottomSectionDivider.isHidden = false
            }
            return cell

        case "Pinned":
            let cell = tableView.dequeueReusableCell(withIdentifier: "MainMenuCategoryTableViewCell") as! MainMenuCategoryTableViewCell
            cell.configue(with: projects?[indexPath.row].projectName ?? "failed")
            //            Draw a line and the end of this section
            if indexPath.row == (projects?.count ?? 1) - 1 {
                cell.bottomSectionDivider.isHidden = false
            }
            return cell
            
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "MainMenuCategoryTableViewCell") as! MainMenuCategoryTableViewCell
            let area = todoManager.areas[indexPath.section]
            
            if area.isOpen {
                if indexPath.row == 0 {
                    cell.configue(with: area.title!)
                    return cell
                } else {
                    cell.configue(with: "area.projects[indexPath.row - 1].projectName")
                    if indexPath.row == area.projects!.count {
                        cell.bottomSectionDivider.isHidden = false
                    }
                    return cell
                }
            } else {
                cell.configue(with: area.title!)
                cell.bottomSectionDivider.isHidden = false
                return cell
            }
            
        }
        
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        if indexPath.section == 1 {
            performSegue(withIdentifier: "toInbox", sender: self)
        }
        
        if indexPath.section == 2 {
            performSegue(withIdentifier: "toInbox", sender: self)
        }
        
        if indexPath.section > 2 {
            if indexPath.row == 0 {
                self.todoManager.areas[indexPath.section].isOpen  = !self.todoManager.areas[indexPath.section].isOpen
                tableView.reloadSections([indexPath.section], with: .none)
            } else {
                performSegue(withIdentifier: "toInbox", sender: self)
            }
            
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
   
    @IBAction func addBtnTapped(_ sender: UIButton) {
        let popUpVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "popUpAdd") as! AddMainMenuAlertViewController
        popUpVC.delegate = self
        self.addChild(popUpVC)
        popUpVC.view.frame = self.view.frame
        self.view.addSubview(popUpVC.view)
        popUpVC.didMove(toParent: self)
    }
    //hide navigation bar from root (this viewcontroller class), before controller will disappear, make nav var visible again.
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "toInbox" {
            if let indexPath = self.MainMenuTableView.indexPathForSelectedRow {
                let controller = segue.destination as! InboxViewController
                let selectedArea = todoManager.areas[indexPath.section]
                let selectedProject = (selectedArea.projects?.allObjects as! [Project]).sorted { ProjectA, ProjectB in
                    ProjectA.arrayIndex < ProjectB.arrayIndex
                }[indexPath.row]
                controller.project = selectedProject
            }
        }
        
        if segue.identifier == "logOut" {
            let controller = segue.destination as! LoginViewController
            controller.autoLogin = false
        }
    }

}

