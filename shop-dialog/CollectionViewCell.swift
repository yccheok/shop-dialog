//
//  CollectionViewCell.swift
//  shop-dialog
//
//  Created by Yan Cheng Cheok on 16/04/2022.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var title: UILabel!

    @IBOutlet weak var _description: UILabel!
    
    static func getUINib() -> UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.black.cgColor
    }

}
