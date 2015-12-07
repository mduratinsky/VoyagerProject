//
//  ConfirmTourViewController.swift
//  Voyager
//
//  Created by Michael Duratinsky on 12/5/15.
//  Copyright © 2015 Voyager. All rights reserved.
//

import Foundation

class ConfirmTourViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancel(sender: UIBarButtonItem) {
        //Dismiss view controller
        self.dismissViewControllerAnimated(true, completion: {})
    }

    
}