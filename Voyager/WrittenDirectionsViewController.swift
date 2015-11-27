//
//  WrittenDirectionsViewController.swift
//  Voyager
//
//  Created by Brett Oberg on 11/26/15.
//  Copyright © 2015 Voyager. All rights reserved.
//

import UIKit

class WrittenDirectionsViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    
    var directions: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        textView.text = directions
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
