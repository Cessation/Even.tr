//
//  Event.swift
//  eventr
//
//  Created by Clayton Petty on 3/23/16.
//  Copyright © 2016 cessation. All rights reserved.
//

import UIKit

class Event: NSObject {

    var title: NSString?
    var desc: NSString?
    var startTime: NSString?
    var endTime: Int = 0
    var picture: UIImage?
    var hashtags: [NSString]?
    var author: NSString
    var eventId: NSString
    
    init(dictionary: NSDictionary) {
        // Event Title
        title = dictionary["title"] as? String
        
        // Event Description
        desc = dictionary["description"] as? String
        
        // Start time
//        let timestampString = dictionary["start_time"] as? String
//        if let timestampString = timestampString {
//            let formatter = NSDateFormatter()
//            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
//            timestamp = formatter.dateFromString(timestampString)
//        }
        
        
        // End time
//        let timestampString = dictionary["end_time"] as? String
//        if let timestampString = timestampString {
//            let formatter = NSDateFormatter()
//            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
//            timestamp = formatter.dateFromString(timestampString)
//        }
        
        // Picture
        picture = dictionary["picture"] as? UIImage
        
        // Hashtags
        hashtags = dictionary["hashtags"] as? [String]
        
        // Author
        author = dictionary["author"] as! String
        
        // Event Id
        eventId = dictionary["id"] as! String
        
        
    }
    
    class func eventsFromArray(dictionaries: [NSDictionary]) -> [Event] {
        var events = [Event]()
        
        for dictionary in dictionaries {
            let event = Event(dictionary: dictionary)
            events.append(event)
        }
        return events
    }
    
     /* Method to add an event to Parse */
    class func postUserImage(withCompletion completion: PFBooleanResultBlock?) {
        // Create Parse object PFObject
        let event = PFObject(className: "Event")
        
        // Add relevant fields to the object
        event["title"] = title // PFFile column type
        event["description"] = desc // Pointer column type that points to PFUser
//        event["start_time"] = 
//        event["end_time"] =
        event["picture"] = getPFFileFromImage(image: picture)
        event["hashtags"] = hashtags
        event["author"] = author
        event["id"] = id
        
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
