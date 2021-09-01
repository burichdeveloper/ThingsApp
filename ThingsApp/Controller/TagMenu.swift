//
//  CalendarPickerPopUpViewController.swift
//  Assignment2
//
//  Created by Rodrigo Dominguez burich on 2021-06-10.
//
import Foundation
import UIKit

class TagMenu: UIViewController {

    weak var delegate: TagDelegate?
    var tags: [Tag]? = TodoManager.sharedDataManager.tags
    
    
    @IBOutlet weak var tagTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tagTableView.dataSource = self
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        // Do any additional setup after loading the view.
        
        
    }

    @IBAction func doneTapped(_ sender: UIButton) {
        
        var selectedTagsId: [String] = []
        if  let selectedTagsIndexes = tagTableView.indexPathsForSelectedRows {
            for indexPath in selectedTagsIndexes {
                let tagId = (tags?[indexPath.row].tagId)!
                selectedTagsId.append(tagId)
            }
        }
        delegate?.onSelectedTags(tagIdArray: selectedTagsId)
        self.view.removeFromSuperview()
    }
}

extension TagMenu: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tags != nil {
            return tags!.count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tagTableView.dequeueReusableCell(withIdentifier: "tagCell")!
        cell.textLabel?.text = self.tags![indexPath.row].tagName
        return cell
    }
    
    
}
