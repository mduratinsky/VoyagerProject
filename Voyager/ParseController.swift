//
//  ParseController.swift
//  Voyager
//
//  Created by Satyam Dhar on 11/20/15.
//  Copyright © 2015 Voyager. All rights reserved.
//

import Foundation
import Parse

/*protocol findTours {
    func findToursBySearchValue(key: String, value: String) -> [Tour]
    func findRecentTours(count : Int)
    //func findToursByKey(key: String, value: Int) -> [Tour]

}*/

protocol ParseAPIControllerProtocol {
    func receivedToursList(results: NSArray)        // When toursList is loaded
    func receivedRecentToursList(results: NSArray)  // When recentList is loaded
    func receivedSearchToursList(results: NSArray)  // When searchList is loaded
}

class ParseController {
    
    var delegate: ParseAPIControllerProtocol

    let logLabel = "ParseController:"   // Beginning of string for in NSLog
    
    var toursList   : [Tour]        // List of all Tours
    var recentList  : [Tour]        // List of most recent tours
    var searchList  : [Tour]        // List of previously searched tours
    
    let NUM_TOTAL   : Int = 50          // Number of total tours to load at a time
    let NUM_RECENT  : Int = 20          // Number of recently added tours to load at a time
    let NUM_SEARCHED: Int = 25          // Number of queried tours by key/value
    
    
    /***************************************************************************
     *      Functions for Initial Loading of Tours from Parse
     ***************************************************************************/
    
    /* 
     *  Initial Setup of ParseController Fields
     */
    init(delegate: ParseAPIControllerProtocol){
        NSLog("\(self.logLabel) init")
        toursList = [Tour]()
        recentList = [Tour]()
        searchList = [Tour]()
        self.delegate = delegate
        self.loadTours()
        self.findRecentTours()
    }
    
    /***************************************************************************
     *      Functions for returning lists of tours (search by ...)
     ***************************************************************************/
    
    /*
     *  Initial Setup of toursList
     *
     *  Loads 1st NUM_TOTAL Tours in Parse Database into toursList field
     */
    func loadTours() {
        let query = PFQuery(className:"Tour")
        var tourObj : Tour = Tour(name: "", locations: [], category: "", author: "", description: "")
        query.limit = NUM_TOTAL  // Default is 100, if not specified
        query.findObjectsInBackgroundWithBlock {
            ( tours: [PFObject]?, error: NSError?) -> Void in
            if (error == nil) {
                // The find succeeded. The first 100 objects are available in objects
                for tour in tours! {
                    tourObj = Tour(name: "", locations: [], category: "", author: "", description: "")
                    tourObj.mOwnerId = tour["ownerId"] as! String
                    tourObj.mName = tour["name"] as! String
                    let list: [PFObject] = tour["listOfLocations"] as! [PFObject]
                    tourObj.mListOfLocations = self.parseTourLocations(list)
                    tourObj.mCategory = tour["category"] as! String
                    tourObj.views = tour["views"] as! Int
                    tourObj.starts = tour["starts"] as! Int
                    tourObj.completes = tour["completes"] as! Int
                    tourObj.mDescription = (tour["description"] as! String)
                    tourObj.mRating = (tour["rating"] as! NSString).integerValue
                //tourObj["image"] = getImageAsParseFile(tour)
                    self.toursList.append(tourObj)
                    NSLog("\(self.logLabel) tour added = \(tourObj.getName())")
                }
                
                NSLog("\(self.logLabel) # tours added = \(self.toursList.count)")
                if self.toursList.count > 0 {
                    self.delegate.receivedToursList(self.toursList)
                }

            } else {
                // Log details of the failure
                NSLog("\(self.logLabel) loadTours: Error: ", error!);
            }
        };
        
    }
    
    /*
     *  Returns toursList field
     *  To be called in receivedRecentToursList
     */
    func getToursList() -> [Tour] {
        NSLog("\(self.logLabel) # toursList = \(self.toursList.count)")
        return toursList
    }
    
    /*
     * Returns list of tours that match criteria given by key and value
     *
     * Parameters:
     *      key   = the means to search by
     *      value = the value to look for in a Tour's "key" field
     */
    func findToursBySearchValue(key : String, value : String) -> [Tour] { // User ID
        let query = PFQuery(className:"Tour")
        var tourObj : Tour = Tour(name: "", locations: [], category: "", author: "", description: "")
        query.limit = NUM_SEARCHED
        query.whereKey(key, equalTo: value)
        query.findObjectsInBackgroundWithBlock {
            ( tours: [PFObject]?, error: NSError?) -> Void in
                if error == nil {
                    for tour in tours! {
                        tourObj = Tour(name: "", locations: [], category: "", author: "", description: "")
                        tourObj.mOwnerId = tour["ownerId"] as! String
                        tourObj.mName = tour["name"] as! String
                        let list: [PFObject] = tour["listOfLocations"] as! [PFObject]
                        tourObj.mListOfLocations = self.parseTourLocations(list)
                        tourObj.mCategory = tour["category"] as! String
                        tourObj.views = tour["views"] as! Int
                        tourObj.starts = tour["starts"] as! Int
                        tourObj.completes = tour["completes"] as! Int
                        tourObj.mDescription = (tour["description"] as! String)
                        tourObj.mRating = (tour["rating"] as! NSString).integerValue
//                      tourObj["image"] = getImageAsParseFile(tour)
                        self.searchList.append(tourObj)
                        NSLog("\(self.logLabel) search tour added = \(tourObj.getName())")
                    }
                    
                    NSLog("\(self.logLabel) # search tours added = \(self.searchList.count)")
                    if self.searchList.count > 0 {
                        self.delegate.receivedSearchToursList(self.searchList)
                    }
                    
                } else {
                    // Log details of the failure
                    NSLog("\(self.logLabel) findToursBySearchValue: Error: ", error!);
            }
        }
        return self.toursList
    }
    
    /*
     *  Returns searchList field
     *  To be called in receivedRecentToursList
     */
    func getSearchedList() -> [Tour] {
        NSLog("\(self.logLabel) # searchTours = \(self.toursList.count)")
        return searchList
    }

    /*
     * Returns list of most recent tours
     *
     * Parameters:
     *      count = # of tours to return in the list
     */
    func findRecentTours() {
        let query = PFQuery(className:"Tour")
        var tourObj : Tour = Tour(name: "", locations: [], category: "", author: "", description: "")
        query.limit = NUM_RECENT
        query.orderByDescending("createdAt")
        query.findObjectsInBackgroundWithBlock {
            ( tours: [PFObject]?, error: NSError?) -> Void in
            if error == nil {
                for tour in tours! {
                    tourObj = Tour(name: "", locations: [], category: "", author: "", description: "")
                    tourObj.mOwnerId = tour["ownerId"] as! String
                    tourObj.mName = tour["name"] as! String
                    let list: [PFObject] = tour["listOfLocations"] as! [PFObject]
                    tourObj.mListOfLocations = self.parseTourLocations(list)
                    tourObj.mCategory = tour["category"] as! String
                    tourObj.views = tour["views"] as! Int
                    tourObj.starts = tour["starts"] as! Int
                    tourObj.completes = tour["completes"] as! Int
                    tourObj.mDescription = (tour["description"] as! String)
                    tourObj.mRating = (tour["rating"] as! NSString).integerValue
                    
                    self.recentList.append(tourObj)
                    NSLog("\(self.logLabel) recent tour added = \(tourObj.getName())")
                }
                
                NSLog("\(self.logLabel) # recent tours added = \(self.recentList.count)")
                if self.recentList.count > 0 {
                    self.delegate.receivedRecentToursList(self.recentList)
                }
            } else {
                // Log details of the failure
                NSLog("\(self.logLabel) Error: recent tour", error!);
            }
        }
    }
    
    /*
     *  Returns recentList field
     *  To be called in receivedRecentToursList
     */
    func getRecentList() -> [Tour] {
        NSLog("\(self.logLabel) # searchTours = \(self.toursList.count)")
        return recentList
    }
    
    
    /***************************************************************************
     *      Functions for Persisting to Parse (creating & updating Tours)
     ***************************************************************************/
    
     /*
      * Adds a new Tour to the Parse Database
      *
      * Parameters:
      *      Tour = the newly created tour to add to the database
      */
    func addTourByUserId (tour: Tour) -> Void {
        
        let tourObj = PFObject(className: "Tour")
        var listOfLocations : [PFObject] = []
        tourObj["name"] = tour.mName
        
        for location in tour.mListOfLocations {
            let locObj = PFObject(className: "Location")
            locObj["name"] = location.mName
            locObj["longitude"] = location.mLongitude
            locObj["latitude"] = location.mLongitude
            listOfLocations.append(locObj)
        }
        
        tourObj["listOfLocations"] = listOfLocations
        tourObj["category"] = tour.mCategory
        tourObj["ownerId"] = tour.mOwnerId
        tourObj["views"] = tour.views
        tourObj["starts"] = tour.starts
        tourObj["completes"] = tour.completes
        tourObj["description"] = tour.mDescription
        tourObj["rating"] = tour.mRating
        //        tourObj["image"] = getImageAsParseFile(tour)
        
        tourObj["image"] = getImageAsParseFile(tour)
        
        tourObj.saveInBackgroundWithBlock {
            (success: Bool,error: NSError?) -> Void in
            if success == true {
                print("Tour created with ID: \(tourObj.objectId)")
            } else {
                print(error)
            }
        }
        //tourObj["comments"] = tour.mComments
    }
    
    
    /***************************************************************************
     *      Miscellaneous Functions
     ***************************************************************************/
    
     /*
      * Returns image from a given tour
      *
      * Parameters:
      *      Tour = tour to get the image file from
      */
    func getImageAsParseFile(tour: Tour) -> PFFile? {
        if tour.image != nil {
            let data = UIImageJPEGRepresentation(tour.image!, 1.0)
            return PFFile(data: data!)
        } else {
            print("error in reading image")
            return nil
        }
    }
    /*func getImageAsParseFile(tour: PFObject) -> UIImage? {
        if tour["image"] == nil {
            return nil
        }
        let userImageFile = tour["image"] as! PFFile
        var image : UIImage!
        
        userImageFile.getDataInBackgroundWithBlock {
            (imageData: NSData?, error: NSError?) -> Void in
            
            //var image: UIImage! = UIImage(data: imageData!)!
            //cell?.imageViewCell?.image = image
            
            if error == nil {
                image = UIImage(data: imageData!)!
            }
        }
        return image
    }*/
    
    /*
     * Given a list of locations from Parse database from a Tour object, 
     * parses it into Location objects and returns the list of them.
     *
     * Parameters:
     *      list = list of objects from Parse database to transfer into this app
     */
    func parseTourLocations(list: [PFObject]) -> [Location] {
        let locationObj = Location(name: "",longitude: 0.0,latitude: 0.0)
        var listOfLocations : [Location] = []
        let locQuery = PFQuery(className:"Location")
        locQuery.limit = list.count  // Default is 100, if not specified
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
                // Log details of the failure
                NSLog("\(self.logLabel) Error: location", error!);
            }
        }
        return listOfLocations
    }
    
}
