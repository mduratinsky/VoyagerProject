//
//  CategoryTableViewCell.swift
//  Voyager
//
//  Created by Brett Oberg on 11/2/15.
//  Copyright © 2015 Voyager. All rights reserved.
//

import UIKit

class CategoryTableViewCell: MKTableViewCell {

    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var categoryTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCell(title: String, image: String) {
        categoryTitle.text = title
        
        //TODO - update the picture
    }
    
}
