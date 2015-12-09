//
//  DiscoverViewController.swift
//  Voyager
//
//  Created by Brett Oberg on 10/30/15.
//  Copyright © 2015 Voyager. All rights reserved.
//

import UIKit
import Parse

class DiscoverViewController:  UIViewController, UITableViewDataSource, UITableViewDelegate, ParseAPIControllerProtocol {
    
    var api : ParseController!

    @IBOutlet weak var discoverTableView: UITableView!
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var tourCell: String? = nil
    var tours: [Tour] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        spinner.hidden = false
        spinner.startAnimating()
        
        /* Initialize API Control */
        api = ParseController(delegate: self)
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        
        discoverTableView.registerNib(UINib(nibName: "DiscoverTableViewCell", bundle: nil), forCellReuseIdentifier: "discoverCell")
        
        // Do any additional setup after loading the view.
    }
    
    func receivedToursList(results: NSArray) {
        spinner.hidden = true
        spinner.stopAnimating()
        dispatch_async(dispatch_get_main_queue(), {
            self.tours = self.api.getToursList()
            self.discoverTableView!.reloadData()
            UIApplication.sharedApplication().networkActivityIndicatorVisible
                = false
        })
    }
    
    func receivedRecentToursList(results: NSArray) {
        spinner.hidden = true
        spinner.stopAnimating()
        dispatch_async(dispatch_get_main_queue(), {
            self.tours = self.api.getToursList()
            self.discoverTableView!.reloadData()
            UIApplication.sharedApplication().networkActivityIndicatorVisible
                = false
        })
    }
    
    func receivedSearchToursList(results: NSArray) {
        spinner.hidden = true
        spinner.stopAnimating()
        dispatch_async(dispatch_get_main_queue(), {
            self.tours = self.api.getToursList()
            self.discoverTableView!.reloadData()
            UIApplication.sharedApplication().networkActivityIndicatorVisible
                = false
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: TableView
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tours.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        //1. Create a new custom cell for the list
        let cell: DiscoverTableViewCell = discoverTableView.dequeueReusableCellWithIdentifier("discoverCell") as! DiscoverTableViewCell
        
        //2. Get the cell attributes
        let title: String = tours[indexPath.row].getName()
        let rating: Int = tours[indexPath.row].getRating()
        
        cell.rippleLocation = .TapLocation
        cell.rippleLayerColor = UIColor.whiteColor()
        
        //3. Set the cells attributes
        cell.setCell(title, rating: rating)

        //4. Return the cell
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("specificCategory") as! IndividualCategoryViewController
        navigationController?.pushViewController(vc, animated: true)
        
        //Set the category title and pass it to the new view controller
        tourCell = tours[indexPath.row].getName()
        if tourCell == nil {
            tourCell = ""
        }
        vc.navTitle = tourCell
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
