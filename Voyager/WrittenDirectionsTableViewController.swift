//
//  WrittenDirectionsTableViewController.swift
//  Voyager
//
//  Created by Brett Oberg on 12/4/15.
//  Copyright © 2015 Voyager. All rights reserved.
//

import UIKit

class WrittenDirectionsTableViewController: UITableViewController {

 
    @IBOutlet var mTableView: UITableView!
    
    var directions: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(directions.count)
    }
    
    // MARK: - Table View
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return directions.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cell = mTableView.dequeueReusableCellWithIdentifier("directionCell") as! DirectionTableViewCell

        let directionTitle = directions[indexPath.row]

        cell.setCell(directionTitle)
        return cell
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
