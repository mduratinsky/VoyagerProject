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
    var category: String? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        categoriesTableView.registerNib(UINib(nibName: "CategoryTableViewCell", bundle: nil), forCellReuseIdentifier: "categoryCell")
        
        //For testing
        var newCategory = Category(name: "Arts", image: UIImage(named: "arts")!)
        categories.append(newCategory)
        newCategory = Category(name: "Bars", image: UIImage(named: "bars")!)
        categories.append(newCategory)
        newCategory = Category(name: "Dancing", image: UIImage(named: "dancing")!)
        categories.append(newCategory)
        newCategory = Category(name: "Dining", image: UIImage(named: "dining")!)
        categories.append(newCategory)
        newCategory = Category(name: "Sports", image: UIImage(named: "sports")!)
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
        let image: UIImage = categories[indexPath.row].getPhoto()
        
        cell.rippleLocation = .TapLocation
        cell.rippleLayerColor = UIColor.whiteColor()
        
        //3. Set the cells attributes
        cell.setCell(title, image: image)
        
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
}
