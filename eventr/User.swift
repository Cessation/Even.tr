//
//  User.swift
//  eventr
//
//  Created by Sagar  on 3/25/16.
//  Copyright © 2016 cessation. All rights reserved.
//

import UIKit

class User: NSObject {
    
    var email: String?
    var firstName: String?
    var lastName: String?
    var events: [Event]?
    var dictionary: NSDictionary?
    
    init(dictionary: NSDictionary){
        
        self.dictionary = dictionary
        firstName = dictionary["first_name"] as? String
        lastName = dictionary["last_name"] as? String
        email = dictionary["email"] as? String
        events = dictionary["events"] as? [Event]
    }
    
    static var _currentUser: User?
    
    class var currentUser: User? {
        get {
        if _currentUser == nil {
        let defaults = NSUserDefaults.standardUserDefaults()
        let userData = defaults.objectForKey("currentUserData") as? NSData
        if let userData = userData {
        let dictionary = try! NSJSONSerialization.JSONObjectWithData(userData, options: []) as! NSDictionary
        _currentUser = User(dictionary: dictionary)
        }
        }
        return _currentUser
        }
        set(user){
            _currentUser = user
            let defaults = NSUserDefaults.standardUserDefaults()
            if let user =  user {
                
                let data =  try! NSJSONSerialization.dataWithJSONObject(user.dictionary!, options: [])
                
                defaults.setObject(data, forKey: "currentUserData")
            } else {
                defaults.setObject(nil, forKey: "currentUserData")
            }
            defaults.synchronize()
        }
        
    }

}
