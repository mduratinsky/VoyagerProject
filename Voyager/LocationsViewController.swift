//
//  LocationsViewController.swift
//  Voyager
//
//  Created by Michael Duratinsky on 12/7/15.
//  Copyright © 2015 Voyager. All rights reserved.
//

import Foundation
import UIKit
import Parse

class LocationsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var numberOfLocations = 0;
    var locationTitle: String = "nothing"
    var locationsHolder: [Location] = []
    
    var tourName: String = ""
    var tourDescription: String = ""
    var tourCategories: String = ""
    var passedImage : UIImage = UIImage(named: "placeholder_scene.png")!
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if let destViewController = segue.destinationViewController as? ConfirmTourViewController {
            destViewController.locationsHolder = self.locationsHolder
            destViewController.tourTitle = self.tourName
            destViewController.tourDescription = self.tourDescription
            destViewController.tourCategory = self.tourCategories
            destViewController.image = passedImage
        }
    }
    
    override func viewDidLoad() {
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
    }
    
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    override func viewWillAppear(animated: Bool) {
        tableView.reloadData()
        //print(numberOfLocations)
        //print(locationTitle)
    }
    
    @IBAction func cancel(sender: UIBarButtonItem) {
        //Dismiss view controller
        self.dismissViewControllerAnimated(true, completion: {})
    }
    
    @IBAction func resetTwo(sender: UIStoryboardSegue) {
        //Allows future views to get back to find this view ID
        //self.tableView.reloadData()
        //print("WAAAAAAAAAAYYYY********TOGO")
    }
    
    /* MARK: - Tableview */
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locationsHolder.count
        //return 20
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("locationCell", forIndexPath: indexPath) as! TourTableListCell
        
        cell.rippleLocation = .TapLocation
        cell.rippleLayerColor = UIColor.MKColor.Grey
        
        let title: String = locationsHolder[indexPath.row].getName()
        
        cell.setCell(title)
        
        return cell
    }

    
}