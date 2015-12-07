//
//  IndividualCategoryViewController.swift
//  Voyager
//
//  Created by Brett Oberg on 11/16/15.
//  Copyright © 2015 Voyager. All rights reserved.
//

import UIKit

class IndividualCategoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var navBar: UINavigationItem!
    
    var navTitle: String? = nil
    var tours: [Tour]? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navBar.title = navTitle!
        
        loadTours()
    }
    
    /* MARK: - General */
    func loadTours() {
        //Testing
        let tour = Tour(name: "A test tour", locations: [], category: "Arts", author: "Brett Oberg", description: "This tour is a fun tour that everyone will enjoy.")
        
        tours!.append(tour)
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
        
        cell.setCell(title, image: "Test")
        
        return cell
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "tourSelected" {
            
        }
    }


}
