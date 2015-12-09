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
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //Add parse object
    }
    
    override func viewDidLoad() {
        //Do Something
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
    
}