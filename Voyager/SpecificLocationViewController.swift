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
    
    var locations: [Location] = []
    var currLocationIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Testing ----------------
        locationTitle.text = "Nitty Gritty"
        //locationTitle.text = locations[0].getName()
        print(locations.count)
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
    
    func goToNextLocation() {
        if (currLocationIndex + 1) >= locations.count {
            //Segue to the rating view
            self.performSegueWithIdentifier("ratingView", sender: nil)
        } else {
            //Update the information for the new location
            
        }
        
        
        currLocationIndex++
    }
    
    @IBAction func nextButtonSelected(sender: MKButton) {
        goToNextLocation()
    }
    
    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "mapLocation" {
            let vc:DirectionsViewController = segue.destinationViewController as! DirectionsViewController
            vc.locationTitle = self.locationTitle.text!
        }
    }


}
