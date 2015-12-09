//
//  SpecificTourViewController.swift
//  Voyager
//
//  Created by Brett Oberg on 11/20/15.
//  Copyright © 2015 Voyager. All rights reserved.
//

import UIKit

class SpecificTourViewController: UIViewController {
    
    @IBOutlet weak var photoGallery: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var startButton: MKButton!
    @IBOutlet weak var tourDescription: UITextView!
    @IBOutlet weak var tourRating: UILabel!
    @IBOutlet weak var tourAuthor: UILabel!
    @IBOutlet weak var tourTitle: UILabel!
    
    var tour: Tour = Tour()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set up the scroll view
        scrollView.scrollEnabled = true
        scrollView.contentSize.height = 486
        scrollView.contentSize.width = self.view.frame.width
        
        //Set up the screen info
        setTourInfo()
    }
    
    /* MARK: - General Functions */
    func setTourInfo() {
        //1. Set the tours image
        tourTitle.text = tour.getName()
        tourDescription.text = tour.getDescription()
        //4. Set the locations
        //tourRating.text = tour.getRating()
        tourAuthor.text = tour.getAuthor()
        
    }
    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "startTour" {
            let destination = segue.destinationViewController as? SpecificLocationViewController
            destination?.locations = tour.getListOfLocations()
        }
    }

}
