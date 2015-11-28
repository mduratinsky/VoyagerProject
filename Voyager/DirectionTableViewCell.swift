//
//  DirectionTableViewCell.swift
//  Voyager
//
//  Created by Brett Oberg on 11/27/15.
//  Copyright © 2015 Voyager. All rights reserved.
//

import UIKit

class DirectionTableViewCell: UITableViewCell {

    @IBOutlet weak var directionTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCell(direction: String) {
        directionTitle.text = direction
    }

}
