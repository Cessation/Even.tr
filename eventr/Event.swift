//
//  Event.swift
//  eventr
//
//  Created by Clayton Petty on 3/23/16.
//  Copyright © 2016 cessation. All rights reserved.
//

import UIKit

class Event: NSObject {

    var title: String?
    var desc: NSString?
    var startDate: String?
    var startTime: String?
    var endTime: String?
    var endDate: String?
    var picture: UIImage?
    var hashtags: [NSString]?
    var author: NSString
    var eventId: NSString
    var attendees: [String]?
    
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
    
        startDate = dictionary["startDate"] as? String
        startTime = dictionary["startTime"] as? String
        endDate = dictionary["endDate"] as? String
        endTime = dictionary["endTime"] as? String
        
        //list of attendees by their key
        // the number of attendees can be found with this
        attendees = dictionary["attendees"] as? [String]
        
    }
    
    class func eventsFromArray(dictionaries: [NSDictionary]) -> [Event] {
        var events = [Event]()
        
        for dictionary in dictionaries {
            let event = Event(dictionary: dictionary)
            events.append(event)
        }
        return events
    }
    
   
}
