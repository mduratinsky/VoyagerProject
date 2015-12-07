//
//  DiscoverViewController.swift
//  Voyager
//
//  Created by Brett Oberg on 10/30/15.
//  Copyright © 2015 Voyager. All rights reserved.
//

import UIKit

class DiscoverViewController:  UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var discoverTableView: UITableView!
    
    //var categories: [Category] = []
    //var category: String? = nil
    
    var tours: [Tour] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        discoverTableView.registerNib(UINib(nibName: "DiscoverTableViewCell", bundle: nil), forCellReuseIdentifier: "discoverCell")
        
        //For testing
        /*var newCategory = Category(name: "Arts", image: UIImage(named: "arts")!)
        categories.append(newCategory)
        newCategory = Category(name: "Bars", image: UIImage(named: "bars")!)
        categories.append(newCategory)
        newCategory = Category(name: "Dancing", image: UIImage(named: "dancing")!)
        newCategory = Category(name: "Dining", image: UIImage(named: "dining")!)
        categories.append(newCategory)*/
        // Do any additional setup after loading the view.
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
        //let title: String = categories[indexPath.row].getName()
        //let image: UIImage = categories[indexPath.row].getPhoto()
        
        let title: String = tours[indexPath.row].getName()
        let rating: Int = tours[indexPath.row].getRating()
        
        /*@IBOutlet weak var titleLabel: UILabel!
        @IBOutlet weak var ratingLabel: UILabel!
        @IBAction func upButton(sender: AnyObject) {
        }
        @IBAction func downButton(sender: AnyObject) {
        }*/

        
        cell.rippleLocation = .TapLocation
        cell.rippleLayerColor = UIColor.whiteColor()
        
        //3. Set the cells attributes
        cell.setCell(title, rating)
        
        //4. Return the cell
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("specificCategory") as! IndividualCategoryViewController
        navigationController?.pushViewController(vc, animated: true)
        
        //Set the category title and pass it to the new view controller
        category = categories[indexPath.row].getName()
        vc.navTitle = category
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
