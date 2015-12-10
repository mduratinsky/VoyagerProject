//
//  SpecificTourViewController.swift
//  Voyager
//
//  Created by Brett Oberg on 11/20/15.
//  Copyright © 2015 Voyager. All rights reserved.
//

import UIKit

class SpecificTourViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var photoGallery: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var startButton: MKButton!
    @IBOutlet weak var tourDescription: UITextView!
    @IBOutlet weak var tourRating: UILabel!
    @IBOutlet weak var tourAuthor: UILabel!
    @IBOutlet weak var tourTitle: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    
    var tour: Tour = Tour()
    var locations: [Location] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set up the scroll view
        scrollView.scrollEnabled = true
        scrollView.contentSize.height = 486
        scrollView.contentSize.width = self.view.frame.width
        
        //Set up the screen info
        setTourInfo()
        locations = tour.getListOfLocations()
    }
    
    /* MARK: - General Functions */
    
    func setTourInfo() {
        //1. Set the tours image
        tourTitle.text = tour.getName()
        tourDescription.text = tour.getDescription()
        //tourRating.text = tour.getRating()
        tourAuthor.text = tour.getAuthor()
        
    }
    
    /* MARK: - Table View */
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("locationCell") as! LocationTableViewCell
        
//        cell.rippleLocation = .TapLocation
//        cell.rippleLayerColor = UIColor.MKColor.Grey
        
        let title: String = locations[indexPath.row].getName()
        cell.setCell(title)
        
        return cell
    }
    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "startTour" {
            if let destination = segue.destinationViewController as? UINavigationController {
                let destVC = destination.viewControllers.first as! SpecificLocationViewController
                destVC.tour = self.tour
            }
        }
    }

}
