//
//  LocationTableViewCell.swift
//  Voyager
//
//  Created by Brett Oberg on 12/9/15.
//  Copyright © 2015 Voyager. All rights reserved.
//

import UIKit

class LocationTableViewCell: UITableViewCell {

    @IBOutlet weak var locationTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setCell(title: String) {
        locationTitle.text = title
    }
}
