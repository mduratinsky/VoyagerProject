//
//  LocationsViewController.swift
//  Voyager
//
//  Created by Michael Duratinsky on 12/7/15.
//  Copyright © 2015 Voyager. All rights reserved.
//

import Foundation
import UIKit
import Parse

class LocationsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var numberOfLocations = 0;
    var locationTitle: String = "nothing"
    
    
    
    override func viewDidLoad() {
        
    }
    
    override func viewWillAppear(animated: Bool) {
        tableView.reloadData()
        //print(numberOfLocations)
        //print(locationTitle)
    }
    
    @IBAction func cancel(sender: UIBarButtonItem) {
        //Dismiss view controller
        self.dismissViewControllerAnimated(true, completion: {})
    }
    
    @IBAction func resetTwo(sender: UIStoryboardSegue) {
        //Allows future views to get back to find this view ID
        //self.tableView.reloadData()
        //print("WAAAAAAAAAAYYYY********TOGO")
    }
    
    /* MARK: - Tableview */
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfLocations
        //return 20
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("locationCell", forIndexPath: indexPath) as! TourTableListCell
        
        cell.rippleLocation = .TapLocation
        cell.rippleLayerColor = UIColor.MKColor.Grey
        
        //title: String = tours![indexPath.row].getName()
        
        cell.setCell(locationTitle)
        
        return cell
    }

    
}