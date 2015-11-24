//
//  SpecificLocationViewController.swift
//  Voyager
//
//  Created by Brett Oberg on 11/23/15.
//  Copyright © 2015 Voyager. All rights reserved.
//

import UIKit

class SpecificLocationViewController: UIViewController {

    @IBOutlet weak var locationTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Testing ----------------
        locationTitle.text = "Nitty Gritty"
    }


    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "mapLocation" {
            let vc:DirectionsViewController = segue.destinationViewController as! DirectionsViewController
            vc.locationTitle = self.locationTitle.text!
        }
    }


}
