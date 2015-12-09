//
//  TourTableListCell.swift
//  Voyager
//
//  Created by Michael Duratinsky on 12/7/15.
//  Copyright © 2015 Voyager. All rights reserved.
//

import UIKit

class TourTableListCell: MKTableViewCell {
    
    
    @IBOutlet weak var tourName: UILabel!
    
    override var layoutMargins: UIEdgeInsets {
        get { return UIEdgeInsetsZero }
        set(newVal) {}
    }
    
    func setCell(title: String) {
        self.tourName.text = title
    }
}
