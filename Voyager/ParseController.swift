//
//  ParseController.swift
//  Voyager
//
//  Created by Satyam Dhar on 11/20/15.
//  Copyright © 2015 Voyager. All rights reserved.
//

import Foundation
import Parse

protocol ParseAPIControllerProtocol {
    func loadLocations(objId: String, list: [Location])
    func receivedToursList(results: [Tour])        // When toursList is loaded
    func receivedCategoriesList(results: [Tour])  // When searchList is loaded
}

class ParseController {
    
    var delegate: ParseAPIControllerProtocol

    let logLabel = "ParseController:"   // Beginning of string for in NSLog
    
    var toursList   : [Tour]        // List of all Tours
    
    let NUM_TOTAL   : Int = 25          // Number of total tours to load at a time
    let NUM_SEARCHED: Int = 20
    
    /***************************************************************************
     *      Functions for Initial Loading of Tours from Parse
     ***************************************************************************/
    
    /* 
     *  Initial Setup of ParseController Fields
     */
    init(delegate: ParseAPIControllerProtocol){
        NSLog("\(self.logLabel) init")
        toursList = [Tour]()
        self.delegate = delegate
        self.loadTours()
    }
    
    /***************************************************************************
     *      Functions for returning lists of tours (search by ...)
     ***************************************************************************/
    
    /*
     *  Initial Setup of toursList
     *
     *  Loads NUM_TOTAL Tours in Parse Database into toursList field, by top rating
     */
    func loadTours() {
        let query = PFQuery(className:"Tour")
        var tourObj : Tour = Tour(name: "", locations: [], category: "", author: "", description: "")
        query.limit = NUM_TOTAL                 // Default is 100, if not specified
        query.orderByDescending("rating")       // use "createdAt" for recent list
        query.findObjectsInBackgroundWithBlock {
            ( tours: [PFObject]?, error: NSError?) -> Void in
            if (error == nil) {
                for tour in tours! {
                    tourObj = Tour(name: "", locations: [], category: "", author: "", description: "")
                    tourObj.mOwnerId = tour["ownerId"] as! String
                    tourObj.mName = tour["name"] as! String
                    tourObj.objectId = tour.objectId! as String
                    let list: [PFObject] = tour["listOfLocations"] as! [PFObject]
                    tourObj.mListOfLocations = self.parseTourLocations(tourObj.objectId, list: list)
                    tourObj.mCategory = tour["category"] as! String
                    tourObj.views = tour["views"] as! Int
                    tourObj.starts = tour["starts"] as! Int
                    tourObj.completes = tour["completes"] as! Int
                    tourObj.mDescription = (tour["description"] as! String)
                    tourObj.mRating = tour["rating"] as! Int
                    //tourObj.image = self.getParseFileAsUIImage(tour)
                    self.toursList.append(tourObj)
                    NSLog("\(self.logLabel) tour added = \(tourObj.getName())")
                }
                NSLog("\(self.logLabel) # tours added = \(self.toursList.count)")
                self.delegate.receivedToursList(self.toursList)
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
     *      value = the value to look for in a Tour's "key" field
     */
    func findCategoriesList(value : String) -> [Tour] {
        let query = PFQuery(className:"Tour")
        var tourObj : Tour = Tour(name: "", locations: [], category: "", author: "", description: "")
        var searchList : [Tour] = []
        query.limit = NUM_SEARCHED
        query.whereKey("category", equalTo: value)
        query.orderByDescending("rating")
        query.findObjectsInBackgroundWithBlock {
            ( tours: [PFObject]?, error: NSError?) -> Void in
                if error == nil {
                    for tour in tours! {
                        tourObj = Tour(name: "", locations: [], category: "", author: "", description: "")
                        tourObj.mOwnerId = tour["ownerId"] as! String
                        tourObj.mName = tour["name"] as! String
                        tourObj.objectId = tour.objectId! as String
                        let list: [PFObject] = tour["listOfLocations"] as! [PFObject]
                        tourObj.mListOfLocations = self.parseTourLocations(tourObj.objectId, list: list)
                        tourObj.mCategory = tour["category"] as! String
                        tourObj.views = tour["views"] as! Int
                        tourObj.starts = tour["starts"] as! Int
                        tourObj.completes = tour["completes"] as! Int
                        tourObj.mDescription = (tour["description"] as! String)
                        tourObj.image = self.getParseFileAsUIImage(tour)
                        tourObj.mRating = tour["rating"] as! Int
                        searchList.append(tourObj)
                        NSLog("\(self.logLabel) search tour added = \(tourObj.getName())")
                    }
                    self.delegate.receivedCategoriesList(searchList)
                } else {
                    // Log details of the failure
                    NSLog("\(self.logLabel) findCategoriesList: Error: ", error!);
            }
        }
        return self.toursList
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
        print("in add tour by user ID")
        let tourObj = PFObject(className: "Tour")
        var listOfLocations : [PFObject] = []
        tourObj["name"] = tour.mName
        
//        print("Before the for loop")
        
        for location in tour.mListOfLocations {
            let locObj = PFObject(className: "Location")
            locObj["name"] = location.mName
            locObj["longitude"] = location.mLongitude
            locObj["latitude"] = location.mLatitude
            locObj["description"] = location.mDescription
            locObj["index"] = location.mIndex
            if tourObj.objectId == nil {
                NSLog("\(self.logLabel) addTour: objectId is nil")
            } else {
                locObj["tourId"] = tourObj.objectId
            }
            
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
        tourObj["image"] = getImageAsParseFile(tour.image)
        
        tourObj.saveInBackgroundWithBlock {
            (success: Bool,error: NSError?) -> Void in
            if success == true {
                var locations = tourObj["listOfLocations"]
                var tourLocs = tour.getListOfLocations()
                
                for i in 0...locations.count-1 {
                    var query = PFQuery(className:"Location")
                    query.getObjectInBackgroundWithId((locations[i].objectId?!)!) {
                        (loc: PFObject?, error: NSError?) -> Void in
                        if error != nil {
                            print(error)
                        } else if let loc = loc {
                            loc["tourId"] = tourObj.objectId
                            loc.saveInBackground()
                        }
                    }
                    tourLocs[i].mTourId = tourObj.objectId!
                }
                tour.objectId = tourObj.objectId!
                self.toursList.append(tour)
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
    func getImageAsParseFile(image: UIImage?) -> PFFile? {
        if image != nil {
            let data = UIImageJPEGRepresentation(image!, 1.0)
            return PFFile(data: data!)
        } else {
            print("NIL Image found!")
            return nil
        }
    }
    
    func getParseFileAsUIImage(tour : PFObject) -> UIImage? {
        if tour["image"] != nil {
            let image = tour["image"] as! PFFile
            let uiimg = try! image.getData()
            return UIImage(data: uiimg)
        } else {
            return UIImage(named: "placeholder_scene.jpg")
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
     *      tourId = the tour object id that the locations correspond to
     *      list = list of objects from Parse database to transfer into this app
     */
    func parseTourLocations(tourId: String, list: [PFObject]) -> [Location] {
        var locationObj = Location(name: "",longitude: 0.0,latitude: 0.0, des: "", tourId: "", ind: 0)
        var listOfLocations : [Location] = []
        let locQuery = PFQuery(className:"Location")
        locQuery.limit = list.count  // Default is 100, if not specified
        locQuery.whereKey("tourId", equalTo: tourId)
        locQuery.findObjectsInBackgroundWithBlock {
            ( locs: [PFObject]?, error: NSError?) -> Void in
            if (error == nil) {
                for obj in locs! {
                    locationObj = Location(name: "",longitude: 0.0,latitude: 0.0, des: "", tourId: "", ind: 0)
                    locationObj.mName = obj["name"] as! String
                    locationObj.mLatitude = obj["latitude"] as! Double
                    locationObj.mLongitude = obj["longitude"] as! Double
                    if obj["description"] != nil {
                        locationObj.mDescription = obj["description"] as! String
                    } else {
                        locationObj.mDescription = ""
                    }
                    locationObj.mTourId = obj["tourId"] as! String
                    locationObj.mIndex = obj["index"] as! Int
                    listOfLocations.append(locationObj)
                }
                listOfLocations.sortInPlace({ $0.mIndex < $1.mIndex })
                NSLog("\(self.logLabel) locations added = \(listOfLocations.count)")
                NSLog("\(self.logLabel) total locations added = \(listOfLocations)")
                if listOfLocations.count > 0 {
                    self.delegate.loadLocations(tourId, list: listOfLocations)
                } else {
                    self.delegate.loadLocations(tourId, list: [])
                }
            } else {
                // Log details of the failure
                NSLog("\(self.logLabel) Error: location", error!);
            }
        }
        //NSLog("\(self.logLabel) total locations added = \(listOfLocations)")
        return listOfLocations
    }
    
    
    
    func getTourIndexByObjectId(objId: String, list: [Tour]) -> Int? {
        //var i: Int = 0
        if list.count == 0 {
            return -1
        }
        for i in 0...list.count-1 {
            if list[i].objectId == objId {
                return i
            }
        }
        return -1
    }
    
    func getTourByIndex(index: Int, list: [Tour]) -> Tour? {
        //var i: Int = 0
        return list[index]
    }
    
}
