//
//  NewTourViewController.swift
//  Voyager
//
//  Created by Michael Duratinsky on 12/5/15.
//  Copyright © 2015 Voyager. All rights reserved.
//

import Foundation
import Parse

class NewTourViewController: UIViewController, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITableViewDelegate {
    
    let parseController = ParseController()
    
    
    
    @IBOutlet weak var tourName: MKTextField!
    @IBOutlet weak var category: MKTextField!
    @IBOutlet weak var tourDescription: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tourDescription.delegate = self
        tourName.placeholder = "Enter tour name"
        category.placeholder = "Enter category"
        tourDescription.text = "Enter tour description"
        tourDescription.textColor = UIColor.lightGrayColor()
        //Eventually add Border color
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var tour = Tour()
        if PFUser.currentUser() != nil {
            
            //Save the tour object
            let tName = tourName.text!
            let tCategory = self.category.text!
            let tDescription = tourDescription.text!
            tour = Tour(name: tName, locations: [], category: tCategory, author: "Test", description: tDescription)
            
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
        /*
        let destViewController = (segue.destinationViewController as! AddingLocationsViewController)
        
        destViewController.tour = tour
        */

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
