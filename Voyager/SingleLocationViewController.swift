//
//  SingleLocationViewController.swift
//  Voyager
//
//  Created by Michael Duratinsky on 12/6/15.
//  Copyright © 2015 Voyager. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
import AddressBook
import MapKit
import Parse

class SingleLocationViewController: UIViewController, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, DataEnteredDelegate {
    
    //var imageView: UIImageView!
    
    @IBOutlet weak var locationInformation: UITextView!
    //@IBOutlet weak var locationInformation: UITextField!
    
    @IBOutlet weak var locationName: UITextField!
    //@IBOutlet weak var locationName: UITextField!
    
    @IBOutlet weak var locationText: UILabel!
    //@IBOutlet weak var locationText: UILabel!
    
    @IBOutlet weak var imageText: UILabel!
    //@IBOutlet weak var imageText: UILabel!
    
    var locationLabelText = String()
    var locationFlag = 0
    var imageFlag = 0
    var coords: CLLocationCoordinate2D?
    
    @IBAction func reset(sender: UIStoryboardSegue) {
        //Do something
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destViewController = (segue.destinationViewController as! LocationsViewController)
        destViewController.numberOfLocations = destViewController.numberOfLocations + 1
        destViewController.locationTitle = locationName.text!
        
        print(destViewController.numberOfLocations)
        print(destViewController.locationTitle)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        locationInformation.delegate = self
        locationName.placeholder = "Enter tour name"
        locationInformation.text = "Enter tour description"
        locationInformation.textColor = UIColor.lightGrayColor()
        locationText.text = locationLabelText
        locationText.textColor = UIColor.lightGrayColor()
        
        
    }
    
    @IBAction func MediaButton(sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) {
            imageFlag = 1
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            imagePicker.allowsEditing = true
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }
    }
    
    func userEnteredInfo(info: String) {
        locationText.text = info
    }
    
    //Sets imageView to the image selected from the users photo library
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        
        //self.imageView.image = image
        //Can Save the image here
        
        imageText.text = "Image Saved"
        
/*        if(imageFlag == 0) {
            //For testing
            let newCategory = Category(name: "Event One", image: image)
            categories.append(newCategory)
        } else if (imageFlag == 2) {
            
            //creating cell and saving image
            var cell: UITableViewCell = singleTourTableView.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
            cell.imageView?.image = image
            self.singleTourTableView.reloadData()
            
        } else {
            imageView.image = image
        }
*/
        self.dismissViewControllerAnimated(true, completion: nil)
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