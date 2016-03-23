//
//  ViewController.swift
//  eventr
//
//  Created by Clayton Petty on 2/24/16.
//  Copyright © 2016 cessation. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    
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
        
        let parameters = ["fields": "email, first_name, last_name"]
        FBSDKGraphRequest(graphPath: "me", parameters: parameters).startWithCompletionHandler { (connection, result, error) -> Void in
            
            if error != nil {
                print(error)
                return
            }
            
            if let email  = result["email"] as? String{
                print(email)
                
            }
            
            if let first_name = result["first_name"] as? String {
                print(first_name)
            }
            
            if let last_name = result["last_name"] as? String {
                print(last_name)
            }
            
            
            self.performSegueWithIdentifier("EventsPage", sender: self)
            
        }
        
    }
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        
            print("Completed login")
            self.performSegueWithIdentifier("EventsPage", sender: self)

    }

    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        
    }
    
    func loginButtonWillLogin(loginButton: FBSDKLoginButton!) -> Bool {
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print("test")
    }


}

