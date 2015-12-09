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
    
    //let parseController = ParseController()
    var api : ParseController!
    
    @IBOutlet weak var tourName: MKTextField!
    
    @IBOutlet weak var tourDescription: UITextView!

    @IBOutlet weak var tourCategory: MKTextField!
    
    /*** Parse Controller API Protocol Functions ***/
    func receivedToursList(results: NSArray) {
        dispatch_async(dispatch_get_main_queue(), {
            // Now have data
            UIApplication.sharedApplication().networkActivityIndicatorVisible
                = false
        })
    }
    
    func receivedRecentToursList(results: NSArray) {
        // Now have data
    }
    
    func receivedSearchToursList(results: NSArray) {
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
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
