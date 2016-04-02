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
    var events: [String]?
    var myevents: [String]? //contains only the title, and id information
    var details: String?
    var profileImage: String?
    
    init(dictionary: NSDictionary){
        
        firstName = dictionary["firstName"] as? String
        lastName = dictionary["lastName"] as? String
        email = dictionary["email"] as? String
        events = dictionary["events"] as? [String]
        myevents = dictionary["myevents"] as? [String]
        details = dictionary["details"] as? String
        profileImage = dictionary["profileImage"] as? String
    }
   
}
