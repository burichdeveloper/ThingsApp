//
//  MainMenuCategoryTableViewCell.swift
//  Assignment3
//
//  Created by Rodrigo Dominguez burich on 2021-06-30.
//

import UIKit

class MainMenuCategoryTableViewCell: UITableViewCell {
    
    static let identifier = "MainMenuCategoryTableViewCell"
    
    @IBOutlet weak var imageContainer: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!

    @IBOutlet weak var bottomSectionDivider: UIView!
    
    
    static func nib() -> UINib {
        return UINib(nibName: "MainMenuCategoryTableViewCell", bundle: nil)
    }
    
    public func configue(with menuCategoryName: String) {
        titleLabel.text = menuCategoryName
        
        bottomSectionDivider.isHidden = true
        
        switch menuCategoryName {
        case "Inbox":
            imageContainer.image = UIImage(systemName: "tray.fill")
            imageContainer.tintColor = UIColor.init(named: "inboxBlue")
            return
            
        case "Today":
            imageContainer.image = UIImage(systemName: "star.fill")
            imageContainer.tintColor = UIColor.init(named: "todayYellow")
            return
        case "Upcoming":
            imageContainer.image = UIImage(systemName: "calendar")
            imageContainer.tintColor = UIColor.init(named: "calendarRed")
            return
            
        case "Anytime":
            imageContainer.image = UIImage(systemName: "tray.fill")
            imageContainer.tintColor = UIColor.init(named: "anytimeGreen")
            return
            
        case "Someday":
            imageContainer.image = UIImage(systemName: "archivebox.fill")
            imageContainer.tintColor = UIColor.init(named: "somedayTan")
            return
            
        case "Logbook":
            imageContainer.image = UIImage(systemName: "book.closed.fill")
            imageContainer.tintColor = UIColor.init(named: "logbookGreen")
            return
        default:
            imageContainer.image = UIImage(systemName: "circle")
            imageContainer.tintColor = UIColor.init(named: "logbookGreen")
            return
        }
        
        
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
