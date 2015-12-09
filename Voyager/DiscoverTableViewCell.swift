//
//  DiscoverTableViewCellController.swift
//  Voyager
//
//  Created by Katherine Richards on 11/18/15.
//  Copyright © 2015 Voyager. All rights reserved.
//

import Foundation

class DiscoverTableViewCell: MKTableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var ratingLabel: UILabel!
    
    @IBAction func upButton(sender: AnyObject) {
    }
    
    @IBAction func downButton(sender: AnyObject) {
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

    func setCell(title: String, rating: Int) {
        titleLabel.text = title
        ratingLabel.text = "\(rating)"
    }}