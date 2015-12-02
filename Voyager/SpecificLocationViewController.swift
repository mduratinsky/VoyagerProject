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
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Testing ----------------
        locationTitle.text = "Nitty Gritty"
    }

    @IBAction func cancelButtonSelected(sender: UIBarButtonItem) {
        cancelAlert()
    }
    
    // MARK: - General Functions
    func cancelAlert() {
        let alert = UIAlertController(title: "Alert", message: "Are you sure you wish to cancel? Your current progress will be lost.", preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.Default, handler: {(action: UIAlertAction!) in
            self.dismissViewControllerAnimated(true, completion: {})
        }))
        alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.Default, handler: nil))

        self.presentViewController(alert, animated: true, completion: nil)
    }

    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "mapLocation" {
            let vc:DirectionsViewController = segue.destinationViewController as! DirectionsViewController
            vc.locationTitle = self.locationTitle.text!
        }
    }


}
