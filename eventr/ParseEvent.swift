//
//  ParseEvent.swift
//  eventr
//
//  Created by Clayton Petty on 3/23/16.
//  Copyright © 2016 cessation. All rights reserved.
//

import UIKit
import Parse

class ParseEvent: NSObject {
   
    /* Method to add an event to Parse 
     (image: UIImage?, withCaption caption: String?, withCompletion completion: PFBooleanResultBlock?) {
     */
    class func postUserEvent(title: NSString, desc: NSString, picture: UIImage, startDate: String, startTime: String, endDate: String, endTime: String, hashtags: [String], author: String, id: String ,withCompletion completion: PFBooleanResultBlock?) {
        // Create Parse object PFObject
        let event = PFObject(className: "Event")
        event["title"] = title
        event["description"] = desc
        event["picture"] = getPFFileFromImage(picture)
        event["startDate"] = startDate
        event["startTime"] = startTime
        event["endDate"] = endDate
        event["endTime"] = endTime
        event["attendees"] = []
        event["hashtags"] = hashtags
        event["author"] = author
        event["id"] = id
        
        // Add relevant fields to the object
//        event["title"] = eventObj.title // PFFile column type
//        event["description"] = eventObj.desc // Pointer column type that points to PFUser
//        event["start_time"] = ""
//        event["end_time"] = ""
//        event["picture"] = getPFFileFromImage(eventObj.picture)
//        event["hashtags"] = eventObj.hashtags
//        event["author"] = eventObj.author
//        event["id"] = eventObj.eventId
        
        // Save object (following function will save the object in Parse asynchronously)
        event.saveInBackgroundWithBlock(completion)
    }
    
    /**
     Method to convert UIImage to PFFile
     
     - parameter image: Image that the user wants to upload to parse
     
     - returns: PFFile for the the data in the image
     */
    class func getPFFileFromImage(image: UIImage?) -> PFFile? {
        // check if image is not nil
        if let image = image {
            // get image data and check if that is not nil
            if let imageData = UIImagePNGRepresentation(image) {
                return PFFile(name: "image.png", data: imageData)
            }
        }
        return nil
    }

}
