//
//  TourTableViewCell.swift
//  Voyager
//
//  Created by Brett Oberg on 11/16/15.
//  Copyright © 2015 Voyager. All rights reserved.
//

import UIKit

class TourTableViewCell: MKTableViewCell {

    
    @IBOutlet weak var tourName: UILabel!
    
    override var layoutMargins: UIEdgeInsets {
        get { return UIEdgeInsetsZero }
        set(newVal) {}
    }
    
    func setCell(title: String, image: String) {
        self.tourName.text = title
        //self.imageView!.image = image
    }
}
