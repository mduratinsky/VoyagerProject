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
    
    var tour: Tour = Tour()
    var locations: [Location] = []
    var latitude: Double = 0
    var longitude: Double = 0
    var currLocationIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locations = tour.mListOfLocations
        setScreen()
    }

    @IBAction func cancelButtonSelected(sender: UIBarButtonItem) {
        cancelAlert()
    }
    
    // MARK: - General Functions
    
    func setScreen() {
        locationTitle.text = locations[currLocationIndex].getName()
        latitude = locations[currLocationIndex].getLatitude()
        longitude = locations[currLocationIndex].getLongitude()
    }
    
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
            currLocationIndex++
            setScreen()
            return
        }
        currLocationIndex++
    }
    
    @IBAction func nextButtonSelected(sender: MKButton) {
        goToNextLocation()
    }
    
    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "mapLocation" {
            if let destination: DirectionsViewController = segue.destinationViewController as? DirectionsViewController {
                print("true")
                destination.locationTitle = self.locationTitle.text!
                destination.locationLatitude = self.latitude
                destination.locationLongitude = self.longitude
            }
        }
    }


}
