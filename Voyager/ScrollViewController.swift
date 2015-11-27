//
//  ScrollViewController.swift
//  Voyager
//
//  Created by Brett Oberg on 10/30/15.
//  Copyright © 2015 Voyager. All rights reserved.
//

import UIKit
import Parse
import FontAwesome_swift

class ScrollViewController: UIViewController {

    @IBOutlet weak var userPhoto: UIBarButtonItem!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var createNewTourButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setScreenScrolling()
        setIcons()
        
        
        // ------------- Testing -------------
        let location1 = Location(name: "UW", longitude: 89.4172, latitude: 43.0750)
        var listOfTestLocations: [Location] = []
        listOfTestLocations.append(location1)
        let category = "Arts"
        
        let location2 = PFObject(className: "Location")
        location2["name"] = "UW";
        location2["longitude"] = 89.4172
        location2["latitude"] = 43.0750
        let location3 = PFObject(className: "Location")
        location3["name"] = "UW";
        location3["longitude"] = 82.4172
        location3["latitude"] = 44.0750
        let location4 = PFObject(className: "Location")
        location4["name"] = "UW";
        location4["longitude"] = 29.4172
        location4["latitude"] = 49.0750

        var listOfTestLocations1: [PFObject] = []
        listOfTestLocations1.append(location2)
        listOfTestLocations1.append(location3)
        listOfTestLocations1.append(location4)
        let tour = PFObject(className: "Tour")
        tour["name"]="Tour2";
        tour["locations"]=listOfTestLocations1
        tour["category"] =  category
        tour["owner"] = "Brett"
//      tour["owner"] = PFUser.currentUser()?["id"]
        
        tour.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            if (success) {
                print("object saved")
            } else {
                print("there was a problem");
            }
        }
        // ------------- Testing -------------
    }
    
    //MARK: - General Functions
    
    func setIcons() {
        let attributes = [NSFontAttributeName: UIFont.fontAwesomeOfSize(25)] as Dictionary!
        userPhoto.setTitleTextAttributes(attributes, forState: .Normal)
        userPhoto.title = String.fontAwesomeIconWithName(.User)
        
        createNewTourButton.setTitleTextAttributes(attributes, forState: .Normal)
        createNewTourButton.title = String.fontAwesomeIconWithName(.Pencil)
    }
    
    func setScreenScrolling() {
        //SearchViewController - placement
        let vc0 = SearchViewController(nibName: "SearchViewController", bundle:  nil)
        
        self.addChildViewController(vc0)
        self.scrollView.addSubview(vc0.view)
        vc0.didMoveToParentViewController(self)
        
        //CategoriesViewController - placement
        let vc1 = CategoriesViewController(nibName: "CategoriesViewController", bundle: nil)
        
        var frame1 = vc1.view.frame
        frame1.origin.x = self.view.frame.size.width
        vc1.view.frame = frame1
        
        self.addChildViewController(vc1)
        self.scrollView.addSubview(vc1.view)
        vc1.didMoveToParentViewController(self)
        
        //DiscoverViewController - placement
        let vc2 = DiscoverViewController(nibName: "DiscoverViewController", bundle: nil)
        
        var frame2 = vc2.view.frame
        frame2.origin.x = self.view.frame.size.width * 2
        vc2.view.frame = frame2
        
        self.addChildViewController(vc2)
        self.scrollView.addSubview(vc2.view)
        vc2.didMoveToParentViewController(self)
        
        //ScrollView characteristics
        let totalScreenWidth = self.view.frame.size.width * 3
        let totalScreenHeight = self.view.frame.size.height - 66
        
        self.scrollView.contentSize = CGSizeMake(totalScreenWidth, totalScreenHeight)
        
        let startingPoint = self.view.frame.size.width
        self.scrollView.contentOffset = CGPoint(x: startingPoint, y: totalScreenHeight)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
