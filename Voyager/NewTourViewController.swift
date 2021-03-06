//
//  NewTourViewController.swift
//  Voyager
//
//  Created by Michael Duratinsky on 12/6/15.
//  Copyright © 2015 Voyager. All rights reserved.
//

import Foundation
import UIKit
import Parse

class NewTourViewController: UIViewController, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITableViewDelegate, ParseAPIControllerProtocol {
    
    var api : ParseController!
    
    @IBOutlet weak var tourName: MKTextField!
    
    @IBOutlet weak var tourDescription: UITextView!
    
    @IBOutlet weak var tourCategory: MKTextField!
    
    @IBOutlet weak var imageText: UILabel!
    
    var passedImage : UIImage = UIImage(named: "placeholder_scene.jpg")!
    
    override func viewDidLoad() {
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        
        tourDescription.delegate = self
        tourName.placeholder = "Enter Tour Name"
        tourCategory.placeholder = "Enter Category Type"
        tourDescription.text = "Enter tour description"
        tourDescription.textColor = UIColor.lightGrayColor()
    }
    
    /*** Parse Controller API Protocol Functions ***/
    func receivedToursList(results: [Tour]) {
        dispatch_async(dispatch_get_main_queue(), {
            // Now have data
            UIApplication.sharedApplication().networkActivityIndicatorVisible
                = false
        })
    }
    
    func receivedCategoriesList(results: [Tour]) {
        // Now have data
    }
    
    func loadLocations(objId: String, list: [Location]) {
        //
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func cancelButton(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: {})
        print("*****123*********")
    }
    
    //@IBAction func cancel(sender: UIBarButtonItem) {
    //    //Dismiss view controller
    //    self.dismissViewControllerAnimated(true, completion: {})
    //    print("*********123************")
    //}
    
    //Detects if user enters info, removes default text and changes text color
    func textViewDidBeginEditing(textView: UITextView) {
        
        if tourDescription.textColor == UIColor.lightGrayColor() {
            tourDescription.text = ""
            tourDescription.textColor = UIColor.blackColor()
        }
    }
    
    //If user does not eneter info, place default text and color
    func textViewDidEndEditing(textView: UITextView) {
        
        if tourDescription.text == "" {
            
            tourDescription.text = "Enter tour description"
            tourDescription.textColor = UIColor.lightGrayColor()
        }
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if let destViewController = segue.destinationViewController as? LocationsViewController {
            destViewController.tourName = self.tourName.text!
            destViewController.tourDescription = self.tourDescription.text!
            destViewController.tourCategories = self.tourCategory.text!
            destViewController.passedImageTwo = self.passedImage
        }
        
        
        
        
        //1. Check to make sure the user has filled out all of the correct fields
        
        //2. Create the tour object
        
        /*
        if PFUser.currentUser() != nil {
        
        //Save the tour object
        let tName = tourName.text!
        let tDescription = tourDescription.text!
        let tCategory = tourCategory.text!
        let tour: Tour = Tour(name: tName, locations: [], category: tCategory, author: "Mike", description: tDescription)
        
        let list : [Tour] = parseController.findToursByKey("Category", value: "Test")
        print(list)
        
        for tour in list {
        print("you entered!")
        print(tour.getName())
        }
        
        parseController.addTourByUserId(tour)
        } else {
        print("error: Please login!")
        }
        
        */
        //Send Data to next view
        //let destViewController = (segue.destinationViewController as! AddingLocationController)
        //destViewController.locationLabelText = thoroughFareInfo
        
    }
    
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    @IBAction func MediaButton(sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) {
            //imageFlag = 1
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            imagePicker.allowsEditing = true
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }
    }
    
    //Sets imageView to the image selected from the users photo library
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        
        //self.imageView.image = image
        //Can Save the image here
        
        imageText.text = "Image Saved"
        self.passedImage = image
        print(self.passedImage)
        
        self.dismissViewControllerAnimated(true, completion: nil)
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
