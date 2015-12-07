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
    
    var tour: Tour = Tour()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set up the scroll view
        scrollView.scrollEnabled = true
        scrollView.contentSize.height = 487
        scrollView.contentSize.width = self.view.frame.width
        
        //Set up the screen info
        
    }


    /* MARK: - General Functions */
    func setTourInfo() {
        
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
