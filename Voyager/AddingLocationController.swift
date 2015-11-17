//
//  AddingLocationController.swift
//  Voyager
//
//  Created by Michael Duratinsky on 11/5/15.
//  Copyright © 2015 Voyager. All rights reserved.
//

import UIKit
import CoreLocation
import AddressBook
import MapKit
import Parse

class AddingLocationController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var locationInformation: UITextView!
    @IBOutlet weak var locationName: UITextField!
    @IBOutlet weak var locationAddText: UILabel!
    var coords: CLLocationCoordinate2D?
    
    //Opens view so user can add location and updates locationText var with information
    @IBAction func locationAddButton(sender: AnyObject) {

    
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationInformation.delegate = self
        
        locationName.placeholder = "Enter tour name"
        locationInformation.text = "Enter tour description"
        locationInformation.textColor = UIColor.lightGrayColor()
        locationAddText.text = "No Location Specified"
        locationAddText.textColor = UIColor.lightGrayColor()
        
        //Eventually add Border color
        
        // Do any additional setup after loading the view.
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancel(sender: UIBarButtonItem) {
        //Dismiss view controller
        self.dismissViewControllerAnimated(true, completion: {})
    }

    //Detects if user enters info, removes default text and changes text color
    func textViewDidBeginEditing(textView: UITextView) {
        
        if locationInformation.textColor == UIColor.lightGrayColor() {
            locationInformation.text = ""
            locationInformation.textColor = UIColor.blackColor()
        }
    }
    
    //If user does not eneter info, place default text and color
    func textViewDidEndEditing(textView: UITextView) {
        
        if locationInformation.text == "" {
            locationInformation.text = "Enter tour description"
            locationInformation.textColor = UIColor.lightGrayColor()
        }
    }

    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}

