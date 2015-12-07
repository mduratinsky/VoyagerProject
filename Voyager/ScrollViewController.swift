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
    var parseController = ParseController()
    @IBOutlet weak var userPhoto: UIBarButtonItem!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var createNewTourButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setScreenScrolling()
        setIcons()
//        if PFUser.currentUser() != nil {
        
            //Save the tour object
//            let tName = "You are my enemy!"
//            let tDescription = "Kill everyone you see."
//            let tour: Tour = Tour(name: tName, locations: [], category: "Arts", author: PFUser.currentUser()!.username!, description: tDescription)
//            parseController.addTourByUserId(tour)
//        } else {
//            print("error: Please login!")
//        }
//        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.White)
//        activityIndicator.center = view.center
//        activityIndicator.startAnimating()
//        view.addSubview(activityIndicator)
//        let tours = parseController.findToursByKey("completes", value: 0)
//        activityIndicator.stopAnimating()

//        print (tours)
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
    
    @IBAction func createNewTourSelected(sender: UIBarButtonItem) {
        if PFUser.currentUser() !=  nil {
            self.performSegueWithIdentifier("createTour", sender: nil)
        } else {
            userNotLoggedInAlert()
        }
        
        print("works")
    }
    
    func userNotLoggedInAlert() {
        let alert = UIAlertController(title: "Alert", message: "You must be logged in to create a tour.", preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction(UIAlertAction(title: "Login", style: UIAlertActionStyle.Default, handler: {(action: UIAlertAction!) in
            self.performSegueWithIdentifier("login", sender: nil)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: nil))
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
}
