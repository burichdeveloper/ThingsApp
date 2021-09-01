//
//  TagCollectionViewCell.swift
//  Assignment3
//
//  Created by Rodrigo Dominguez burich on 2021-07-30.
//

import UIKit

class TagCollectionViewCell: UICollectionViewCell {

    static let identifier = "TagCollectionViewCell"
    
    @IBOutlet weak var backgroundViewContainer: UIView!
    @IBOutlet weak var tagNameLabel: UILabel!
    
    static func nib() -> UINib {
        return UINib(nibName: "TagCollectionViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backgroundViewContainer.layer.cornerRadius = 5
    }

}
