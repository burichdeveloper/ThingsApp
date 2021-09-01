//
//  QuickFindTableViewCell.swift
//  Assignment3
//
//  Created by Rodrigo Dominguez burich on 2021-06-30.
//

import UIKit

class QuickFindTableViewCell: UITableViewCell {
    static let identifier = "QuickFindTableViewCell"
    
    
    static func nib() -> UINib {
        return UINib(nibName: "QuickFindTableViewCell", bundle: nil)
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func quickSearchTapped(_ sender: Any) {
        print("hey")
    }
    
}
