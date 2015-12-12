//
//  TourTableViewCell.swift
//  Voyager
//
//  Created by Brett Oberg on 11/16/15.
//  Copyright © 2015 Voyager. All rights reserved.
//

import UIKit

class TourTableViewCell: MKTableViewCell {

    
    @IBOutlet weak var tourImage: UIImageView!
    @IBOutlet weak var tourName: UILabel!
    
    override var layoutMargins: UIEdgeInsets {
        get { return UIEdgeInsetsZero }
        set(newVal) {}
    }
    
    func setCell(title: String, image: UIImage) {
        self.tourName.text = title
        self.tourImage.image = image
    }
}
