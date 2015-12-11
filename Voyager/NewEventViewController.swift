//
//  NewEventViewController.swift
//  Voyager
//
//  Created by Brett Oberg on 10/30/15.
//  Copyright © 2015 Voyager. All rights reserved.
//

import UIKit
import Parse
class NewEventViewController: UIViewController, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITableViewDelegate, ParseAPIControllerProtocol {
    
    var api : ParseController!
    
    //@IBOutlet weak var tourName: UITextField!
    //@IBOutlet weak var tourName: UITextField!
    @IBOutlet weak var tourName: UITextField!
    @IBOutlet weak var addLocationButton: MKButton!
    
    //@IBOutlet weak var tourDescription: UITextView!
    //@IBOutlet weak var tourDescription: UITextView!
    @IBOutlet weak var tourDescription: UITextView!
    
    //@IBOutlet weak var imageView: UIImageView!
    //@IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageView: UIImageView!
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    //Gives sense that image is button and opens users photo library

    @IBAction func imageButton(sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            imagePicker.allowsEditing = true
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }
    }
/*
    //Gives sense that image is button and opens users photo library
    @IBAction func imageButton(sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            imagePicker.allowsEditing = true
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }
    }
*/
    //Sets imageView to the image selected from the users photo library
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        
        imageView.image = image
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /* Initialize API Control */
        api = ParseController(delegate: self)
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true

        tourDescription.delegate = self
        tourName.placeholder = "Enter tour name"
        tourDescription.text = "Enter tour description"
        tourDescription.textColor = UIColor.lightGrayColor()
        //Eventually add Border color
        
        scrollView.scrollEnabled = true
        scrollView.contentSize.height = 900
        scrollView.contentSize.width = 600
        
        
        //Set button properties
        addLocationButton.cornerRadius = 15.0
        addLocationButton.layer.shadowOpacity = 0.75
        addLocationButton.layer.shadowRadius = 3.5
        addLocationButton.layer.shadowColor = UIColor.blackColor().CGColor
        addLocationButton.layer.shadowOffset = CGSize(width: 1.0, height: 5.5)
        //self.scrollView.contentInset = UIEdgeInsets(top: 45, left: -20, bottom: 0, right: 20)
        
        // Do any additional setup after loading the view.
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
    
    @IBAction func cancel(sender: UIBarButtonItem) {
        //Dismiss view controller
        self.dismissViewControllerAnimated(true, completion: {})
    }

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
    
    @IBAction func createEventButton(sender: MKButton) {
        //1. Check to make sure the user has filled out all of the correct fields
        
        //2. Create the tour object
        
                
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
