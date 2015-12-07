//
//  UserInfoViewController.swift
//  Voyager
//
//  Created by Brett Oberg on 11/15/15.
//  Copyright © 2015 Voyager. All rights reserved.
//

import UIKit
import ParseFacebookUtilsV4
import Parse

class UserInfoViewController: UIViewController {
    @IBOutlet weak var logInOutButton: MKButton!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var favoritesButton: MKButton!
    @IBOutlet weak var myToursButton: MKButton!
    
    @IBAction func logInOut(sender: MKButton) {
        if let _ = PFUser.currentUser()?.username {
            PFUser.logOut()
            userName.text = "Anonymous"
            favoritesButton.hidden = true
            myToursButton.hidden = true
            logInOutButton.setTitle("Login using Facebook", forState: UIControlState.Normal)
            logInOutButton.backgroundColor = UIColor.MKColor.FacebookBlue
            let image = UIImage(named: "placeholder.jpg")
            self.imageView.image = image
        } else {
            let permissions = ["public_profile"]
            PFFacebookUtils.logInInBackgroundWithReadPermissions(permissions) {
                (user: PFUser?, error: NSError?) -> Void in
                if let error = error {
                    print(error)
                } else if let _ = user {
                    let graphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, gender"])
                    graphRequest.startWithCompletionHandler({
                        (connection,result,error) -> Void in
                        
                        if (error != nil) {
                            print(error)
                        } else if (result != nil) {
                            PFUser.currentUser()?["gender"] = result["gender"]
                            PFUser.currentUser()?["name"] = result["name"]
                            
                            let userId = result["id"] as! String
                            let facebookProfilePictureUrl = "https://graph.facebook.com/\(userId)/picture?type=large"
                            print(facebookProfilePictureUrl)
                            if let fbpicUrl = NSURL(string: facebookProfilePictureUrl) {
                                if let data = NSData(contentsOfURL: fbpicUrl) {
                                    let imageFile = PFFile(data: data)
                                    PFUser.currentUser()?["image"] = imageFile
                                    PFUser.currentUser()?.saveInBackground()
                                    
                                }
                            }
                            
                        }
                    })
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favoritesButton.hidden = true
        myToursButton.hidden = true
        imageView.layer.cornerRadius = 100.0
    }
    
    override func viewDidAppear(animated: Bool) {
        let image = UIImage(named: "placeholder.jpg")
        self.imageView.image = image
        
        if let _ = PFUser.currentUser()?.username {
            
            let name = PFUser.currentUser()?["name"] as! String
            userName.text = name
            
            favoritesButton.hidden = false
            myToursButton.hidden = false
            
            logInOutButton.setTitle("Logout", forState: UIControlState.Normal)
            logInOutButton.backgroundColor = UIColor.MKColor.Red
            
            let imageFile = PFUser.currentUser()?["image"] as! PFFile
            imageFile.getDataInBackgroundWithBlock ({
                (imageData: NSData?, error: NSError?) -> Void in
                if error == nil {
                    if let imageData = imageData {
                        let imageFile = UIImage(data:imageData)
                        self.imageView.image = imageFile
                        
                    }
                }
                }, progressBlock: {
                    (percentDone: Int32) -> Void in
                    print("progress = \(percentDone)")
            })
            
        } else {
            logInOutButton.setTitle("Login using Facebook", forState: UIControlState.Normal)
            logInOutButton.backgroundColor = UIColor.MKColor.FacebookBlue
            userName.text = "Anonymous"
        }

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
