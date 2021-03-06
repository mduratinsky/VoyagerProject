//
//  ConfirmTourViewController.swift
//  Voyager
//
//  Created by Michael Duratinsky on 12/9/15.
//  Copyright © 2015 Voyager. All rights reserved.
//

import Foundation
import UIKit
import Parse

class ConfirmTourViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,ParseAPIControllerProtocol  {
    
    
    @IBOutlet weak var rTourTitle: UILabel!
    @IBOutlet weak var rTourDescription: UITextView!
    @IBOutlet weak var tableView: UITableView!
    
    var imageHolder : UIImage = UIImage(named: "placeholder_scene.jpg")!
    var api : ParseController!
    var tourTitle : String = ""
    var tourDescription : String = ""
    var tourCategory : String = ""
    var locationsHolder: [Location] = []

    
    
    
    
    @IBAction func createTour(sender: MKButton) {
        //        print("******************")
        //        print(tourTitle)
        //        print(tourDescription)
        //        print(tourCategory)
        //        print(locationsHolder)
        //        print("******************")
        
        
        let tour = Tour(name: tourTitle, locations: locationsHolder, category: tourCategory, author: "Mike", description: tourDescription)
        
        
        //let image = UIImage(named: "placeholder.jpg")
        //tour.image = image
        
        print("******************")
        print(tour.getName())
        print(tour.getListOfLocations())
        print(tour.getCategory())
        print(tour.getAuthor())
        print(tour.getDescription())
        print(tour.getListOfLocations()[0].mLongitude)
        print(tour.getListOfLocations()[0].mLatitude)
        print("******************")
        
        
        //api.addTourByUserId(tour)
        
        tour.image = self.imageHolder
        api.addTourByUserId(tour)
        
        
        print("Image2", UIImage(named: "placeholder_scene.jpg")!)
        print("IMAGE!!!!",self.imageHolder)
        print("A TOUR WAS ADDED!!!!!!!!!!!")
        
        
        self.dismissViewControllerAnimated(true, completion: {})
    }
    
    override func viewDidLoad() {
        //Do Something
        /* Initialize API Control */
        api = ParseController(delegate: self)
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        
        rTourTitle.text = tourTitle
        rTourDescription.text = tourDescription
        
    }
    
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
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
        
    }
    
    override func viewWillAppear(animated: Bool) {
        tableView.reloadData()
        //print(numberOfLocations)
        //print(locationTitle)
    }

    /* MARK: - Tableview */
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let cell: TourCreateListCell = tableView.dequeueReusableCellWithIdentifier("confirmCell") as! TourCreateListCell
        
        cell.rippleLocation = .TapLocation
        cell.rippleLayerColor = UIColor.MKColor.Grey
        
        let title: String = locationsHolder[indexPath.row].getName()
        
        cell.setCell(title)
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locationsHolder.count
        //return 20
    }
    
    
}