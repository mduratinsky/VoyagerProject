//
//  RateTourViewController.swift
//  Voyager
//
//  Created by Brett Oberg on 12/5/15.
//  Copyright © 2015 Voyager. All rights reserved.
//

import UIKit

class RateTourViewController: UIViewController {

    @IBOutlet weak var ratingTextField: MKTextField!
    @IBOutlet weak var reviewTextView: UITextView!
    @IBOutlet weak var addToFavoritesButton: MKButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    
    @IBAction func skipButtonSelected(sender: MKButton) {
        self.dismissViewControllerAnimated(true, completion: {})
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
