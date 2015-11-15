//
//  UserInfoViewController.swift
//  Voyager
//
//  Created by Brett Oberg on 11/15/15.
//  Copyright © 2015 Voyager. All rights reserved.
//

import UIKit

class UserInfoViewController: UIViewController {

    @IBOutlet weak var userPhoto: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpScreen()
    }
    
    // MARK: - General
    
    func setUpScreen() {
        userPhoto.font = UIFont.fontAwesomeOfSize(200)
        userPhoto.text = String.fontAwesomeIconWithName(.User)
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
