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

class ConfirmTourViewController: UIViewController, ParseAPIControllerProtocol  {
    
    var api : ParseController!
    
    
    var tourTitle : String = ""
    var tourDescription : String = ""
    var tourCategory : String = ""
    var locationsHolder: [Location] = []
    
    
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
//        print("******************")
//        print(tourTitle)
//        print(tourDescription)
//        print(tourCategory)
//        print(locationsHolder)
//        print("******************")
        
        
        let tour = Tour(name: tourTitle, locations: locationsHolder, category: tourCategory, author: "Mike", description: tourDescription)
        
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
        api.addTourByUserId(tour)
        
        print("A TOUR WAS ADDED!!!!!!!!!!!")
        
    }
    
    override func viewDidLoad() {
        //Do Something
    }
    
    /*** Parse Controller API Protocol Functions ***/
    func receivedToursList(results: NSArray) {
        dispatch_async(dispatch_get_main_queue(), {
            // Now have data
            UIApplication.sharedApplication().networkActivityIndicatorVisible
                = false
        })
    }
    
    func receivedRecentToursList(results: NSArray) {
        // Now have data
    }
    
    func receivedSearchToursList(results: NSArray) {
        // Now have data
    }
    
}