//
//  IndividualCategoryViewController.swift
//  Voyager
//
//  Created by Brett Oberg on 11/16/15.
//  Copyright © 2015 Voyager. All rights reserved.
//

import UIKit
import Parse

class IndividualCategoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var navBar: UINavigationItem!
    @IBOutlet weak var loadingLabel: UILabel!
    @IBOutlet weak var spinner: UIActivityIndicatorView!

    
    
    var navTitle: String? = nil
    var tours: [Tour]? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navBar.title = navTitle!
        
        //Hide the tableView while data loads
        tableView.hidden = true
        spinner.hidden = false
        spinner.startAnimating()
        loadingLabel.hidden = false
        
        loadTours()
    }
    
    /* MARK: - General */
    
    func loadTours() {
        findToursByKey("category", value: navTitle!)
    }
    
    func findToursByKey(key : String, value : String){ // User ID
       
        let query = PFQuery(className:"Tour")
        let tourObj : Tour = Tour(name: "", locations: [], category: "", author: "", description: "")
        var locationObj = Location(name: "",longitude: 0.0,latitude: 0.0)
        var listOfLocations : [Location] = []
        query.whereKey(key, equalTo: value)
        query.findObjectsInBackgroundWithBlock {
            ( toursList: [PFObject]?, error: NSError?) -> Void in
            if error == nil {
           
                for tour in toursList! {
                    listOfLocations = []
                    tourObj.mOwnerId = tour["ownerId"] as! String
                    tourObj.mName = tour["name"] as! String
                    let list: [PFObject] = tour["listOfLocations"] as! [PFObject]
                    let locQuery = PFQuery(className:"Location")
                    locQuery.limit = list.count
                    locQuery.findObjectsInBackgroundWithBlock {
                        ( locs: [PFObject]?, error: NSError?) -> Void in
                        if (error == nil) {
                            for obj in locs! {
                                locationObj.mName = obj["name"] as! String
                                locationObj.mLatitude = obj["latitude"] as! Double
                                locationObj.mLongitude = obj["longitude"] as! Double
                                listOfLocations.append(locationObj) 
                            }
                        } else {
                            print("Error with location")
                        }
                    }
                    tourObj.mListOfLocations = listOfLocations
                    tourObj.mCategory = tour["category"] as! String
                    tourObj.views = tour["views"] as! Int
                    tourObj.starts = tour["starts"] as! Int
                    tourObj.completes = tour["completes"] as! Int
                    tourObj.mDescription = (tour["description"] as! String)
                    tourObj.parseId = tour.objectId
                    tourObj.mRating = (tour["rating"] as! NSString).integerValue
                    if let tourPicture = tour["image"] as? PFFile {
                        tourPicture.getDataInBackgroundWithBlock { (imageData: NSData?, error: NSError?) -> Void in
                            if (error == nil) {
                                tourObj.image = UIImage(data:imageData!)
                                
                            }
                        }
                    }
                    self.tours!.append(tourObj)
                }
                //Show the list while it loads
                self.tableView.hidden = false
                self.spinner.hidden = true
                self.spinner.stopAnimating()
                self.loadingLabel.hidden = true
                
                self.tableView.reloadData()
            }
        }
    }

    
    /* MARK: - Tableview */
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tours!.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 65.0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("tourCell") as! TourTableViewCell
        
        cell.rippleLocation = .TapLocation
        cell.rippleLayerColor = UIColor.MKColor.Grey
        
        let title: String = tours![indexPath.row].getName()
        cell.setCell(title, image: tours![indexPath.row].image!)
        return cell
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "tourSelected" {
            if let destination = segue.destinationViewController as? SpecificTourViewController {
                if let tourIndex: Int = tableView.indexPathForSelectedRow!.row {
                    destination.tour = tours![tourIndex]
                }
            }
        }
    }


}
