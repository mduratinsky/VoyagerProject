//
//  ParseController.swift
//  Voyager
//
//  Created by Satyam Dhar on 11/20/15.
//  Copyright © 2015 Voyager. All rights reserved.
//

import Foundation
import Parse

protocol findTours {
    func findToursByKey(key: String, value: String) -> [Tour]
    func findToursByKey(key: String, value: Int) -> [Tour]

}

class ParseController : findTours {
//    func saveToParse(tour : Tour){
//        
//    }
    
//    getToursByNumberOfViews() -> [
    
    var toursList : [Tour] = []
    
    init(){
        
    }
    
    
    
    func getImageAsParseFile(tour: Tour) -> PFFile? {
        if tour.image != nil {
            let data = UIImageJPEGRepresentation(tour.image!, 1.0)
            return PFFile(data: data!)
        } else {
            print("error in reading image")
            return nil
        }
    }
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
        tourObj["listOfLocations"] = tour.mListOfLocations
        tourObj["category"] = tour.mCategory
        tourObj["ownerId"] = tour.mOwnerId
        tourObj["views"] = tour.views
        tourObj["starts"] = tour.starts
        tourObj["completes"] = tour.completes
        tourObj["description"] = tour.mDescription
        if tour.mRating != nil {
            tourObj["rating"] = tour.mRating
        } else {
            tourObj["rating"] = "No Rating Yet"
        }
//        tourObj["image"] = getImageAsParseFile(tour)
        
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
    
    
    // Functions for returning lists of tours (search by ...)
    func findToursByKey(key : String, value : String) -> [Tour] { // User ID
        let query = PFQuery(className:"Tour")
        let tourObj : Tour = Tour(name: "", locations: [], category: "", author: "", description: "")
        let locationObj = Location(name: "",longitude: 0.0,latitude: 0.0)
        var listOfLocations : [Location] = []
        query.whereKey(key, equalTo: value)
        query.findObjectsInBackgroundWithBlock {
                ( tours: [PFObject]?, error: NSError?) -> Void in
                if error == nil {
                        print("no error")
                        for tour in tours! {
                            print("You found an object to put in your list of tours")
                            listOfLocations = []
                            tourObj.mOwnerId = tour["ownerId"] as! String
                            tourObj.mName = tour["name"] as! String
                            let list: [PFObject] = tour["listOfLocations"] as! [PFObject]
                            for obj in list {
                                locationObj.mName = obj["name"] as! String
                                locationObj.mLatitude = obj["latitude"] as! Double
                                locationObj.mLongitude = obj["longitude"] as! Double
                                listOfLocations.append(locationObj)
                            }
                            tourObj.mListOfLocations = listOfLocations
                            tourObj.mCategory = tour["category"] as! String
                            tourObj.views = tour["views"] as! Int
                            tourObj.starts = tour["starts"] as! Int
                            tourObj.completes = tour["completes"] as! Int
                            tourObj.mDescription = (tour["description"] as! String)
                            tourObj.mRating = tour["rating"] as? Float
//                            tourObj["image"] = getImageAsParseFile(tour)
                            self.toursList.append(tourObj)
                            }
                    for tour in self.toursList{
                        print(tour.getCategory())
                    }
                    
                } else {
                        print(error)
                }
        }
        return self.toursList
    }
    
    func findToursByKey(key : String, value : Int) -> [Tour] { // User ID
        let query = PFQuery(className:"Tour")
        let tourObj : Tour = Tour(name: "", locations: [], category: "", author: "", description: "")
        let locationObj = Location(name: "",longitude: 0.0,latitude: 0.0)
        var listOfLocations : [Location] = []
        var toursList : [Tour] = []
        query.limit = value
        query.orderByDescending(key)
        query.findObjectsInBackgroundWithBlock {
            ( tours: [PFObject]?, error: NSError?) -> Void in
            if error == nil {
                for tour in tours! {
                    listOfLocations = []
                    tourObj.mOwnerId = tour["ownerId"] as! String
                    tourObj.mName = tour["name"] as! String
                    let list: [PFObject] = tour["listOfLocations"] as! [PFObject]
                    for obj in list {
                        locationObj.mName = obj["name"] as! String
                        locationObj.mLatitude = obj["latitude"] as! Double
                        locationObj.mLongitude = obj["longitude"] as! Double
                        listOfLocations.append(locationObj)
                    }
                    tourObj.mListOfLocations = listOfLocations
                    tourObj.mCategory = tour["categoy"] as! String
                    tourObj.views = tour["views"] as! Int
                    tourObj.starts = tour["starts"] as! Int
                    tourObj.completes = tour["completes"] as! Int
                    tourObj.mDescription = (tour["description"] as! String)
                    tourObj.mRating = tour["rating"] as? Float
                    //                            tourObj["image"] = getImageAsParseFile(tour)
                    toursList.append(tourObj)
                }
                
            } else {
                print(error)
            }
        }
        return toursList
    }

    
    
    
    
}

//    query.findObjectsInBackgroundWithBlock {
//        (tours: [AnyObject]?, error: NSError?) -> Void in
//            if error == nil {
//                if let objects = tours as? [PFObject] {
//                    var firstObject = objects[0]
//    
//    
//                }
//            }
//        }
    // Functions for finding a specific tour
//    func getTourById() -> Tour { // Object/Tour ID
//    
//    }
//    
    
