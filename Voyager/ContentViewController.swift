//
//  DiscoverViewController.swift
//  Voyager
//
//  Created by Brett Oberg on 10/19/15.
//  Copyright © 2015 Voyager. All rights reserved.
//

import UIKit

class ContentViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    
    var pageIndex: Int!
    var titleText: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.titleLabel.text = titleText
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
