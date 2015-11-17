//
//  ScrollViewController.swift
//  Voyager
//
//  Created by Brett Oberg on 10/30/15.
//  Copyright © 2015 Voyager. All rights reserved.
//

import UIKit
import Parse
import FontAwesome_swift

class ScrollViewController: UIViewController {

    @IBOutlet weak var userPhoto: UIBarButtonItem!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var createNewTourButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setScreenScrolling()
        setUserPhoto()
    }
    
    //MARK: - General Functions
    
    func setUserPhoto() {
        let attributes = [NSFontAttributeName: UIFont.fontAwesomeOfSize(30)] as Dictionary!
        userPhoto.setTitleTextAttributes(attributes, forState: .Normal)
        userPhoto.title = String.fontAwesomeIconWithName(.User)
        
        createNewTourButton.setTitleTextAttributes(attributes, forState: .Normal)
        createNewTourButton.title = String.fontAwesomeIconWithName(.Pencil)
    }
    
    func setScreenScrolling() {
        //SearchViewController - placement
        let vc0 = SearchViewController(nibName: "SearchViewController", bundle:  nil)
        
        self.addChildViewController(vc0)
        self.scrollView.addSubview(vc0.view)
        vc0.didMoveToParentViewController(self)
        
        //CategoriesViewController - placement
        let vc1 = CategoriesViewController(nibName: "CategoriesViewController", bundle: nil)
        
        var frame1 = vc1.view.frame
        frame1.origin.x = self.view.frame.size.width
        vc1.view.frame = frame1
        
        self.addChildViewController(vc1)
        self.scrollView.addSubview(vc1.view)
        vc1.didMoveToParentViewController(self)
        
        //DiscoverViewController - placement
        let vc2 = DiscoverViewController(nibName: "DiscoverViewController", bundle: nil)
        
        var frame2 = vc2.view.frame
        frame2.origin.x = self.view.frame.size.width * 2
        vc2.view.frame = frame2
        
        self.addChildViewController(vc2)
        self.scrollView.addSubview(vc2.view)
        vc2.didMoveToParentViewController(self)
        
        //ScrollView characteristics
        let totalScreenWidth = self.view.frame.size.width * 3
        let totalScreenHeight = self.view.frame.size.height - 66
        
        self.scrollView.contentSize = CGSizeMake(totalScreenWidth, totalScreenHeight)
        
        let startingPoint = self.view.frame.size.width
        self.scrollView.contentOffset = CGPoint(x: startingPoint, y: totalScreenHeight)
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
