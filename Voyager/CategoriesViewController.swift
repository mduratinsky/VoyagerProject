//
//  CategoriesViewController.swift
//  Voyager
//
//  Created by Brett Oberg on 10/30/15.
//  Copyright © 2015 Voyager. All rights reserved.
//

import UIKit

class CategoriesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var categoriesTableView: UITableView!
    
    var categories: [Category] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoriesTableView.registerNib(UINib(nibName: "CategoryTableViewCell", bundle: nil), forCellReuseIdentifier: "categoryCell")
        
        //For testing
        var newCategory = Category(name: "Arts")
        categories.append(newCategory)
        newCategory = Category(name: "Bars")
        categories.append(newCategory)
        newCategory = Category(name: "Dancing")
        categories.append(newCategory)
        newCategory = Category(name: "Dining")
        categories.append(newCategory)
    }
    
    //MARK: General
    
    
    // MARK: TableView
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        //1. Create a new custom cell for the list
        let cell: CategoryTableViewCell = categoriesTableView.dequeueReusableCellWithIdentifier("categoryCell") as! CategoryTableViewCell
        
        //2. Get the cell attributes
        let title: String = categories[indexPath.row].getName()
        let image: String = "test" //TODO
        
        cell.rippleLocation = .TapLocation
        cell.rippleLayerColor = UIColor.MKColor.Grey
        
        //3. Set the cells attributes
        cell.setCell(title, image: image)
        
        //4. Return the cell
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("specificCategory") as UIViewController
        navigationController?.pushViewController(vc, animated: true)
        //self.presentViewController(vc, animated: true, completion: nil)
    }
    
    // MARK: Navigation
}
