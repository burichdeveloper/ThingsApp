//
//  titleCategoryTableViewCell.swift
//  Assignment3
//
//  Created by Rodrigo Dominguez burich on 2021-07-01.
//

import UIKit

class TitleCategoryTableViewCell: UITableViewCell {

    @IBOutlet weak var imageContainer: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    static let identifier = "TitleCategoryTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "TitleCategoryTableViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure (imageSysName: String, title: String) {
        imageContainer.image = UIImage(systemName: imageSysName)
        imageContainer.tintColor = UIColor(named: "inboxBlue")
        titleLabel.text = title
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
