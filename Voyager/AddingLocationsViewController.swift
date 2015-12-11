//
//  AddingLocationsViewController.swift
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

class AddingLocationsController: UIViewController, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate { //, UITableViewDelegate, UITableViewDataSource {
    
    
    //@IBOutlet weak var TourTableView: UITableView!
    
    //var locationLabelText = String()
    //var locationFlag = 0
    
    //var coords: CLLocationCoordinate2D?
    
    //Used for setting up listview
    //var categories: [Category] = []
    //var category: String? = nil
    //var imageFlag = 0
    @IBAction func resetTwo(sender: UIStoryboardSegue) {
        //Allows future views to get back to find this view ID
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
        TourTableView.registerNib(UINib(nibName: "CategoryTableViewCell", bundle: nil), forCellReuseIdentifier: "categoryCell")
        //For testing
        var newCategory = Category(name: "Arts", image: UIImage(named: "arts")!)
        categories.append(newCategory)
        */
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
    }
    
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancel(sender: UIBarButtonItem) {
        //Dismiss view controller
        self.dismissViewControllerAnimated(true, completion: {})
    }
    
    /*
    //table view functions for delegation purposes
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        //1. Create a new custom cell for the list
        let cell: CategoryTableViewCell = TourTableView.dequeueReusableCellWithIdentifier("categoryCell") as! CategoryTableViewCell
        
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
    */
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
