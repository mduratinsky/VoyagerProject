//
//  RateTourViewController.swift
//  Voyager
//
//  Created by Brett Oberg on 12/5/15.
//  Copyright © 2015 Voyager. All rights reserved.
//

import UIKit

class RateTourViewController: UIViewController {

    @IBOutlet weak var starButton: UIButton!
    @IBOutlet weak var addToFavoritesButton: MKButton!
    @IBOutlet weak var reviewTextView: UITextView!
    
    var favoriteSelected = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reviewTextView.layer.cornerRadius = 5.0
        reviewTextView.layer.borderColor = UIColor.MKColor.Grey.CGColor
        reviewTextView.layer.borderWidth = 1
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
    
        starButton.titleLabel?.font = UIFont.fontAwesomeOfSize(50)
        starButton.setTitle(String.fontAwesomeIconWithName(.StarO), forState: .Normal)
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
    
    @IBAction func starSelected(sender: UIButton) {
        if (favoriteSelected == true) {
            starButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
            starButton.setTitle(String.fontAwesomeIconWithName(.StarO), forState: .Normal)
            favoriteSelected = false
        } else {
            starButton.setTitleColor(UIColor.MKColor.Gold, forState: .Normal)
            starButton.setTitle(String.fontAwesomeIconWithName(.Star), forState: .Normal)
            favoriteSelected = true
        }
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
