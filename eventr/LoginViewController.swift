//
//  ViewController.swift
//  eventr
//
//  Created by Clayton Petty on 2/24/16.
//  Copyright © 2016 cessation. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    var email: String?
    
    let FBLoginButton: FBSDKLoginButton = {
        let button = FBSDKLoginButton()
        button.readPermissions = ["email"]
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(FBLoginButton)
        FBLoginButton.center = view.center
        FBLoginButton.delegate = self
        
        if let _ = FBSDKAccessToken.currentAccessToken(){
            fetchProfile()
        }
    }
    
    func fetchProfile(){
        
        // uses the user's email to see if they are a new user by checking the parse backend. If they exist, the events list associated with that email is loaded from parse else, a new user is added to parse with with a empty events list
        
        let parameters = ["fields": "email,first_name,last_name,picture.type(large)"]
        FBSDKGraphRequest(graphPath: "me", parameters: parameters).startWithCompletionHandler { (connection, result, error) -> Void in
            
            if error != nil {
                print(error)
                return
            }
            
            let firstName = result.objectForKey("first_name") as? String

            let lastName = result.objectForKey("last_name") as? String
            
            let profileImage = result.objectForKey("picture")?.objectForKey("data")?.objectForKey("url") as? String
            
            if let email  = result.objectForKey("email") as? String{
                self.email = email
                let query = PFQuery(className: "User")
                query.whereKey("email", equalTo: email)
                query.findObjectsInBackgroundWithBlock { (users: [PFObject]?, error: NSError?) -> Void in
                    
                    if users?.count != 0 {
                         print("user loaded")
                    } else {
                        ParseUser.postUser(firstName,lastName: lastName,email: email, profileImage: profileImage) { (success: Bool, error: NSError?) in
                            if success {
                                print("user saved")
                            }
                            else{
                                print(error?.localizedDescription)
                            }
                        }
                        
                    }
                    self.performSegueWithIdentifier("EventsPage", sender: self)
                }

            }
            
        }
        
    }
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        
        if let _ = FBSDKAccessToken.currentAccessToken(){
        
            print("Completed login")
            fetchProfile()
            self.performSegueWithIdentifier("EventsPage", sender: self)
        }
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        PFUser.logOut()
    }
    
    func loginButtonWillLogin(loginButton: FBSDKLoginButton!) -> Bool {
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
         let tabBarController = segue.destinationViewController as! UITabBarController
         let navigationViewController0 = tabBarController.viewControllers![0] as! UINavigationController
         let navigationViewController1 = tabBarController.viewControllers![1] as! UINavigationController
         let profileViewController = navigationViewController1.viewControllers[0] as! ProfileViewController
        profileViewController.email = email
        let eventsViewController = navigationViewController0.viewControllers[0] as! EventsViewController
        eventsViewController.email = email
  
        
    }


}

