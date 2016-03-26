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
    
    init(dictionary: NSDictionary){
        
        firstName = dictionary["firstName"] as? String
        lastName = dictionary["lastName"] as? String
        email = dictionary["email"] as? String
        events = dictionary["events"] as? [Event]
    }
   
}
