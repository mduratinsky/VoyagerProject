//
//  SignupViewController.swift
//  Voyager
//
//  Created by Satyam Dhar on 11/7/15.
//  Copyright © 2015 Voyager. All rights reserved.
//

import UIKit
import ParseFacebookUtilsV4
import Parse


class SignupViewController: UIViewController {

    @IBOutlet weak var SkipSignin: UIButton!
    
    @IBOutlet weak var FBSignin: UIButton!
    
    @IBAction func enterApp(sender: UIButton) {
        if sender == SkipSignin {
            
        } else if sender == FBSignin {
            
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
                    
                    self.performSegueWithIdentifier("signinCompleted", sender: self)
                }
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //test facebook
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        
        if let _ = PFUser.currentUser()?.username {
            performSegueWithIdentifier("signinCompleted", sender: self)
        }
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
