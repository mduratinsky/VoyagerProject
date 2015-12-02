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

class AddingLocationController: UIViewController, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITableViewDelegate, UITableViewDataSource, DataEnteredDelegate {
    
    //@IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageView: UIImageView!
    
    //@IBOutlet weak var locationInformation: UITextView!
    @IBOutlet weak var locationInformation: UITextView!
    
    //@IBOutlet weak var locationName: UITextField!
    @IBOutlet weak var locationName: UITextField!
    
    //@IBOutlet weak var locationAddText: UILabel!
    @IBOutlet weak var locationAddText: UILabel!
    
    
    //@IBOutlet weak var singleTourTableView: UITableView!
    @IBOutlet weak var singleTourTableView: UITableView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    var locationLabelText = String()
    var locationFlag = 0
    
    var coords: CLLocationCoordinate2D?
    
    //Used for setting up listview
    var categories: [Category] = []
    var category: String? = nil
    var imageFlag = 0
    
    @IBAction func AddingLocationMediaButton(sender: AnyObject) {
        //print("******HELLO****")
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) {
            imageFlag = 2
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            imagePicker.allowsEditing = true
             self.presentViewController(imagePicker, animated: true, completion: nil)
            
            //var cell: UITableViewCell = singleTourTableView.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
            
            //cell.imageView?.image = imagePicker.
            
        }
    }
    func userEnteredInfo(info: String) {
        locationAddText.text = info
    }
    
    //Opens view so user can add location and updates locationText var with information
    @IBAction func locationAddButton(sender: AnyObject) {
    }
    
    //Gives sense that image is button and opens users photo library
    @IBAction func imageButton(sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) {
            imageFlag = 1
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
            flag = 1
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
        
        if(imageFlag == 0) {
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
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        locationInformation.delegate = self
        
        locationName.placeholder = "Enter tour name"
        locationInformation.text = "Enter tour description"
        locationInformation.textColor = UIColor.lightGrayColor()
        //if(locationFlag == 0) {
            locationAddText.text = locationLabelText
            locationAddText.textColor = UIColor.lightGrayColor()
            //locationFlag == 1
        //} else {
        //    locationAddText.text = locationLabelText
        //    locationAddText.textColor = UIColor.lightGrayColor()
            
        //}
        
        
        singleTourTableView.registerNib(UINib(nibName: "CategoryTableViewCell", bundle: nil), forCellReuseIdentifier: "categoryCell")
        //For testing
        var newCategory = Category(name: "Arts", image: UIImage(named: "arts")!)
        categories.append(newCategory)
        
        scrollView.scrollEnabled = true
        scrollView.contentSize.height = 800
        scrollView.contentSize.width = 600

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
    
    //table view functions for delegation purposes
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        //1. Create a new custom cell for the list
        let cell: CategoryTableViewCell = singleTourTableView.dequeueReusableCellWithIdentifier("categoryCell") as! CategoryTableViewCell
        
        //2. Get the cell attributes
        let title: String = categories[indexPath.row].getName()
        let image: UIImage = categories[indexPath.row].getPhoto()
        
        cell.rippleLocation = .TapLocation
        cell.rippleLayerColor = UIColor.whiteColor()
        
        //3. Set the cells attributes
        cell.setCell(title, image: image)
        
        //4. Return the cell
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("specificCategory") as! IndividualCategoryViewController
        navigationController?.pushViewController(vc, animated: true)
        
        //Set the category title and pass it to the new view controller
        category = categories[indexPath.row].getName()
        vc.navTitle = category
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

