//
//  ParseUser.swift
//  eventr
//
//  Created by Sagar  on 3/25/16.
//  Copyright © 2016 cessation. All rights reserved.
//

import UIKit
import Parse

class ParseUser: NSObject {
    
    //in order to save memory should we remove the first/last name since this information can taken from facebook every time on login. Email would still be needed as a key.
    class func postUser(firstName: String?, lastName: String?, email: String?, profileImage: String?
        ,withCompletion completion: PFBooleanResultBlock?) {
        // Create Parse object PFObject
        let user = PFObject(className: "User")
        user["firstName"] = firstName
        user["lastName"] = lastName
        user["email"] = email
        user["events"] = []
        user["myevents"] = []
        user["details"] = ""
        user["profileImage"] = profileImage
        user.saveInBackgroundWithBlock(completion)
    }
    
    //need to add an addEvent API, so when a user rsvps to going to an event, that event will be added to their events list. As with other changes that can occur

}
