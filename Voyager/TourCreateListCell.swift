//
//  TourCreateListCell.swift
//  Voyager
//
//  Created by Michael Duratinsky on 12/12/15.
//  Copyright © 2015 Voyager. All rights reserved.
//

import UIKit

class TourCreateListCell: MKTableViewCell {
    
    @IBOutlet weak var locationTitle: UILabel!
    
    override var layoutMargins: UIEdgeInsets {
        get { return UIEdgeInsetsZero }
        set(newVal) {}
    }
    
    func setCell(title: String) {
        self.locationTitle.text = title
    }
}
