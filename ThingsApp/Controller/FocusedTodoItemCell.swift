//
//  focusedTodoItemCell.swift
//  Assignment3
//
//  Created by Rodrigo Dominguez burich on 2021-07-09.
//

import UIKit

class FocusedTodoItemCell: UITableViewCell, CalendarDelegate, TagDelegate {
    
    func onSelectedTags(tagIdArray: [String]?) {
//        if let safeArray = tagIdArray {
//            self.todoItem.tags = safeArray
//        }
//        tagListCollectionView.reloadData()
    }
    
    
    func onscheduled(date: Date?) {
        todoItem.scheluedOn = date
        TodoManager.sharedDataManager.saveContext()
        updateVCLayout()
    }
    
    func onDeadline(date: Date?) {
        todoItem.deadlineOn = date
        TodoManager.sharedDataManager.saveContext()
        updateVCLayout()
    }
    

    static let identifier = "FocusedTodoItemCell"
    
    var todoItem: TodoItem = TodoItem()
    var VCContainer: UIViewController = UIViewController()
    
    
    
    
    @IBOutlet weak var heightCollectionView: NSLayoutConstraint!
    
    @IBOutlet weak var tagCollectionView: UICollectionView!
    @IBOutlet weak var collectionLayout: UICollectionViewFlowLayout! {
        didSet {
            collectionLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
    }
    
    @IBOutlet weak var todoTitleTextView: UITextView!
    @IBOutlet weak var todoNotesTextView: UITextView!
    @IBOutlet weak var scheduledstackView: UIStackView!
    @IBOutlet weak var hasDeadlineSV: UIStackView!
    @IBOutlet weak var checklistSV: UIStackView!
    @IBOutlet weak var tagListSV: UIStackView!
    
    @IBOutlet weak var addTagBtn: UIButton!
    @IBOutlet weak var addFileBtn: UIButton!
    @IBOutlet weak var scheduleTodoBtn: UIButton!
    @IBOutlet weak var addCheckListBtn: UIButton!
    @IBOutlet weak var addDeadlineBtn: UIButton!
    @IBOutlet weak var deadlineBtnLabel: UIButton!
    @IBOutlet weak var scheduleBtnLabel: UIButton!
    @IBOutlet weak var tagIcon: UIButton!
    @IBOutlet weak var tagIconHeight: NSLayoutConstraint!
    
    
    @IBOutlet weak var tagListCollectionView: UICollectionView!
    
    
    static func nib() -> UINib {
        return UINib(nibName: "FocusedTodoItemCell", bundle: nil)
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tagListCollectionView.register(TagCollectionViewCell.nib(), forCellWithReuseIdentifier: "TagCollectionViewCell")
        // Initialization code
        self.tagListCollectionView.dataSource = self
        self.tagListCollectionView.delegate = self

        heightCollectionView.constant = collectionLayout.collectionViewContentSize.height / 2
        todoTitleTextView.delegate = self
        todoNotesTextView.delegate = self
    }


    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func scheduleTodoTapped(_ sender: Any) {
        let popUpVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "calendarPicker") as! CalendarPickerPopUpViewController
        popUpVC.popUpTitle = "When?"
        popUpVC.delegate = self
        popUpVC.calendarMenuType = "schedule"
        popUpVC.date = self.todoItem.scheluedOn
        
        
        VCContainer.addChild(popUpVC)
        popUpVC.view.frame = VCContainer.view.frame
        VCContainer.view.addSubview(popUpVC.view)
        popUpVC.didMove(toParent: VCContainer)
        
        for recognizer in VCContainer.view.gestureRecognizers ?? [] {
            VCContainer.view.removeGestureRecognizer(recognizer)
        }
    }
    
    @IBAction func AddDeadlineTapped(_ sender: Any) {
        let popUpVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "calendarPicker") as! CalendarPickerPopUpViewController
        popUpVC.popUpTitle = "Deadline?"
        popUpVC.delegate = self
        popUpVC.calendarMenuType = "deadline"
        popUpVC.date = self.todoItem.deadlineOn
        VCContainer.addChild(popUpVC)
        popUpVC.view.frame = VCContainer.view.frame
        VCContainer.view.addSubview(popUpVC.view)
        popUpVC.didMove(toParent: VCContainer)
        
        for recognizer in VCContainer.view.gestureRecognizers ?? [] {
            VCContainer.view.removeGestureRecognizer(recognizer)
        }
    }
    
    
    @IBAction func addTagsTapped(_ sender: Any) {
        let popUpVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "tagMenu") as! TagMenu
        
        popUpVC.delegate = self
        
        VCContainer.addChild(popUpVC)
        popUpVC.view.frame = VCContainer.view.frame
        VCContainer.view.addSubview(popUpVC.view)
        popUpVC.didMove(toParent: VCContainer)
        
        for recognizer in VCContainer.view.gestureRecognizers ?? [] {
            VCContainer.view.removeGestureRecognizer(recognizer)
        }
    }
    
    func updateVCLayout() {
        
        todoTitleTextView.text = todoItem.title
        todoNotesTextView.text = todoItem.todoDescription

        if todoItem.checkListItems == nil {
            checklistSV.isHidden = false
            addCheckListBtn.isHidden = true
        } else {
            checklistSV.isHidden = true
            addCheckListBtn.isHidden = false
        }

        if todoItem.tags == nil  {
            tagListSV.isHidden = false
            addTagBtn.isHidden = true
        } else {
            tagListSV.isHidden = true
            addTagBtn.isHidden = false
        }

        if todoItem.scheluedOn == nil {
            scheduledstackView.isHidden = true
            scheduleTodoBtn.isHidden = false
        } else {
            let formatter = DateFormatter()
            formatter.dateStyle = .short
            scheduleBtnLabel.setTitle(formatter.string(from: todoItem.scheluedOn!), for: .normal)
            scheduledstackView.isHidden = false
            scheduleTodoBtn.isHidden = true
        }
        
        if todoItem.deadlineOn == nil {
            hasDeadlineSV.isHidden = true
            addDeadlineBtn.isHidden = false
        } else {
            let formatter = DateFormatter()
            formatter.dateStyle = .short
            deadlineBtnLabel.setTitle(formatter.string(from: todoItem.deadlineOn!), for: .normal)
            hasDeadlineSV.isHidden = false
            addDeadlineBtn.isHidden = true
        }
 
    }
    
    
    
    
    
}

extension FocusedTodoItemCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if let safeTagList = todoItem.tagIDList {
//            return safeTagList.count
//        } else {
//            return 0
//        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = tagListCollectionView.dequeueReusableCell(withReuseIdentifier: "TagCollectionViewCell", for: indexPath) as! TagCollectionViewCell
//        let tagID = self.todoItem.tagIDList![indexPath.row]
        let tagName = TodoManager.sharedDataManager.tags.first { tag in
            tag.tagId == ""
        }?.tagName
        
        cell.tagNameLabel.text = tagName!
        
        return cell
    }
    
    
    
}


extension FocusedTodoItemCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if let tagId = todoItem.tagIDList?[indexPath.row] {
//            let popUpVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "tagSelected") as! TagSelectedViewController
//            popUpVC.selectedTagName = tagId
//
//            VCContainer.addChild(popUpVC)
//            popUpVC.view.frame = VCContainer.view.frame
//            VCContainer.view.addSubview(popUpVC.view)
//            popUpVC.didMove(toParent: VCContainer)
//
//            for recognizer in VCContainer.view.gestureRecognizers ?? [] {
//                VCContainer.view.removeGestureRecognizer(recognizer)
//            }
//        }
}
}


extension FocusedTodoItemCell: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) { //Handle the text changes here
            if textView == self.todoTitleTextView {
                if textView.text.isEmpty {
                    todoItem.title = "new Todo"
                } else {
                    todoItem.title = textView.text
                }
                
            } else {
                if textView.text.isEmpty {
                    todoItem.todoDescription = "notes"
                } else {
                    todoItem.todoDescription = textView.text
                }
                
            }
            TodoManager.sharedDataManager.saveContext()
        }
    

    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView == self.todoTitleTextView {
            if todoItem.title == "new Todo" {
                todoItem.title = ""
                todoTitleTextView.textColor = .black
            }
            
        } else {
            if todoItem.todoDescription == "notes" {
                todoItem.todoDescription = ""
                todoNotesTextView.textColor = .black
            }
            
        }
        TodoManager.sharedDataManager.saveContext()
        updateVCLayout()
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView == self.todoTitleTextView {
            if todoItem.title == "" {
                todoItem.title = "new Todo"
                todoTitleTextView.textColor = .gray
            }
            
        } else {
            if todoItem.todoDescription == "" {
                todoItem.todoDescription = "notes"
                todoNotesTextView.textColor = .gray
            }
            
        }
        TodoManager.sharedDataManager.saveContext()
        updateVCLayout()
    }
}
