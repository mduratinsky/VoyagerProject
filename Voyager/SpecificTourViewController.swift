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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.scrollEnabled = true
        scrollView.contentSize.height = 468
        scrollView.contentSize.width = self.view.frame.width
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
