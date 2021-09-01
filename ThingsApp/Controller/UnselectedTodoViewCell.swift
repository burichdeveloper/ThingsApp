//
//  unselectedTodoViewCell.swift
//  Assignment3
//
//  Created by Rodrigo Dominguez burich on 2021-06-30.
//

import UIKit

class UnselectedTodoViewCell: UITableViewCell {

    static let identifier = "UnselectedTodoViewCell"
    var todoItem: TodoItem = TodoItem()
    
    @IBOutlet weak var completedBtnOutlet: UIButton!
    @IBOutlet weak var scheduleDateLabel: UILabel!
    @IBOutlet weak var todoTitleLabel: UILabel!
    @IBOutlet weak var checklistIndicator: UIImageView!
    @IBOutlet weak var tagsIndicator: UIImageView!
    @IBOutlet weak var deadlineIndicator: UIStackView!
    @IBOutlet weak var deadlineLabel: UILabel!
    
    static func nib() -> UINib {
        return UINib(nibName: "UnselectedTodoViewCell", bundle: nil)
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        scheduleDateLabel.layer.masksToBounds = true
        scheduleDateLabel.layer.cornerRadius = 4
        scheduleDateLabel.isHidden = false
    }

    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func completedTapped(_ sender: UIButton) {
        if completedBtnOutlet.isSelected == true {
            completedBtnOutlet.isSelected = false
            todoItem.completed = false
            completedBtnOutlet.setImage(UIImage(systemName: "square"), for: .selected)
        } else {
            completedBtnOutlet.isSelected = true
            completedBtnOutlet.setImage(UIImage(systemName: "checkmark.square"), for: .selected)
            todoItem.completed = true
        }
        TodoManager.sharedDataManager.saveContext()
    }
    
    
    
    func updateView() {
        
        todoTitleLabel.text = todoItem.title
        
        if todoItem.completed {
            print("completed")
            completedBtnOutlet.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
        } else {
            completedBtnOutlet.setImage(UIImage(systemName: "square"), for: .normal)
        }
        
        if todoItem.scheluedOn != nil {
            scheduleDateLabel.isHidden = false
            let formatter = DateFormatter()
            formatter.dateFormat = "MM"
            let month = formatter.string(from: todoItem.scheluedOn!)
            formatter.dateFormat = "dd"
            let day = formatter.string(from: todoItem.scheluedOn!)
            scheduleDateLabel.text = "\(day)-\(month)"
        } else {
            scheduleDateLabel.isHidden = true
        }
        
        if todoItem.checkListItems!.allObjects.count > 0 {
            checklistIndicator.isHidden = false
        } else {
            checklistIndicator.isHidden = true
        }
        
        if todoItem.tags!.allObjects.count > 0 {
            tagsIndicator.isHidden = false
        } else {
            tagsIndicator.isHidden = true
        }
        
        if todoItem.deadlineOn != nil {
            deadlineIndicator.isHidden = false
            let formatter = DateFormatter()
            formatter.dateFormat = "MM"
            let month = formatter.string(from: todoItem.deadlineOn!)
            formatter.dateFormat = "dd"
            let day = formatter.string(from: todoItem.deadlineOn!)
            deadlineLabel.text = "\(day)-\(month)"
        } else {
            deadlineIndicator.isHidden = true
        }
        
        
        
    }
}
