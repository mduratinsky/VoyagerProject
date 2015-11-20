//
//  ParseController.swift
//  Voyager
//
//  Created by Satyam Dhar on 11/20/15.
//  Copyright © 2015 Voyager. All rights reserved.
//

import Foundation
import Parse

class ParseController {
//    func saveToParse(tour : Tour){
//        
//    }
    
//    getToursByNumberOfViews() -> [
    init(){
        
    }
    // Functions for returning lists of tours (search by ...)
    func findToursByUserId(id : String) -> [Tour] { // User ID
    let query = PFQuery(className:"Tour")
    var toursList : [Tour] = []
    query.whereKey("id", equalTo: id)
    query.getObjectInBackgroundWithId("zro6m6gAJw") {
            (tour: PFObject?, error: NSError?) -> Void in
            if error == nil && tour != nil {
                print(tour)
                let tour1 = Tour(name: "", locations: [], category: "", author: "")
                tour1.mAuthor = tour!["owner"] as! String
                tour1.mName = tour!["name"] as! String
                toursList.append(tour1)
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
    
