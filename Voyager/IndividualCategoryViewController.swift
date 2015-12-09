//
//  IndividualCategoryViewController.swift
//  Voyager
//
//  Created by Brett Oberg on 11/16/15.
//  Copyright © 2015 Voyager. All rights reserved.
//

import UIKit
import Parse

class IndividualCategoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,
ParseAPIControllerProtocol {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var navBar: UINavigationItem!
    @IBOutlet weak var loadingLabel: UILabel!
    @IBOutlet weak var spinner: UIActivityIndicatorView!

    var api : ParseController!
    var navTitle: String? = nil
    var tours: [Tour]? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navBar.title = navTitle!
        api = ParseController(delegate: self)
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        
        //Hide the tableView while data loads
        tableView.hidden = true
        spinner.hidden = false
        spinner.startAnimating()
        loadingLabel.hidden = false
        
        api.findCategoriesList(navTitle!)
    }
    
    /* MARK: - Parse controller protocol */
    
    func receivedToursList(results: [Tour]) {
//        tableView.hidden = false
//        loadingLabel.hidden = true
//        spinner.hidden = true
//        spinner.stopAnimating()
//        dispatch_async(dispatch_get_main_queue(), {
//            self.tours = self.api.getToursList()
//            self.tableView!.reloadData()
//            UIApplication.sharedApplication().networkActivityIndicatorVisible
//                = false
//        })
    }
    
    func receivedCategoriesList(results: [Tour]) {
        tours = results 
        tableView.reloadData()
        tableView.hidden = false
        loadingLabel.hidden = true
        spinner.hidden = true
        spinner.stopAnimating()
    }
    
    func loadLocations(objId: String, list: [Location]) {
        var i: Int = 0
        i = api.getTourIndexByObjectId(objId, list: tours!)!
        var tour : Tour?
        if i > -1 {
            tour = api.getTourByIndex(i, list: tours!)
            tour!.mListOfLocations = list
        }
        tableView.reloadData()
        NSLog("IndividualCategoryView: loadLocations = \(list.count)")
        
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
        cell.setCell(title, image: "test")
        print("\(title) has \(tours![indexPath.row].getListOfLocations().count)")
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
