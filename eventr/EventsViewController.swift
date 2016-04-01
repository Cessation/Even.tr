//
//  EventsViewController.swift
//  eventr
//
//  Created by Sagar  on 3/22/16.
//  Copyright © 2016 cessation. All rights reserved.
//

import UIKit
import Parse

class EventsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var events: [PFObject]?
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "refreshControlAction:", forControlEvents: UIControlEvents.ValueChanged)
        tableView.insertSubview(refreshControl, atIndex: 0)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        let query = PFQuery(className: "Event")
        query.orderByDescending("createdAt")
        //query.includeKey("author")
        query.limit = 20
        
        // fetch data asynchronously
        query.findObjectsInBackgroundWithBlock { (events: [PFObject]?, error: NSError?) -> Void in
            if let events = events {
                self.events = events
                self.tableView.reloadData()
                
            } else {
                print("Error")
            }
        }
        
        self.tableView.reloadData()
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logoutButton(sender: AnyObject) {
        print("logout")
        FBSDKLoginManager().logOut()
        self.dismissViewControllerAnimated(true, completion:{})
    }
    
    //Uncomment cell.date...,cell.time..., and cell.attendees when the Heruko backend has been cleaned!!!
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("EventCell", forIndexPath: indexPath) as! EventTableViewCell
        cell.postPic = events![indexPath.row]["picture"] as? PFFile
        cell.title = events![indexPath.row]["title"] as? String
        let startDate = events![indexPath.row]["startDate"] as? String
        let endDate = events![indexPath.row]["endDate"] as? String
        //cell.date = [startDate!,endDate!]
        let startTime = events![indexPath.row]["startTime"] as? String
        let endTime = events![indexPath.row]["endTime"] as? String
        //cell.time = [startTime!, endTime!]
        //cell.attendeesLabel.text = "- \(events![indexPath.row]["attendees"].count)" as? String

        return cell
        
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if events != nil {
            return events!.count
        } else {
            return 0
        }
    }
    

    func refreshControlAction(refreshControl: UIRefreshControl) {
            viewDidAppear(true)
            refreshControl.endRefreshing()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        switch segue.identifier!{
            
            case "EventDetailsSegue":
            let cell = sender as! UITableViewCell
            let indexpath = tableView.indexPathForCell(cell)
            let event = events![indexpath!.row]
            let eventdetailsViewController = segue.destinationViewController as! EventDetailsViewController
        
            let parseAttendees = event["attendees"] as! [PFObject]
            var attendees:[User]
            attendees = []
            for parseAttendee in parseAttendees {
                let dict:[String:AnyObject] = ["firstName":parseAttendee["firstName"] as! String, "lastName":parseAttendee["lastName"] as! String, "email":parseAttendee["email"] as! String]
                let attendee = User(dictionary:dict)
                attendees.append(attendee)
            }
            
            let dict: [String: AnyObject] = ["title":event["title"] as! String, "description":event["description"] as! String, "startTime":event["startTime"] as! String, "endTime":event["endTime"] as! String, "startDate":event["startDate"] as! String, "endDate":event["endDate"] as! String,"picture":event["picture"] as! PFFile, "author": event["author"] as! String, "id": event["id"] as! String, "attendees": attendees, "location":event["location"]]
            eventdetailsViewController.event = Event(dictionary: dict)
            break
            
            case "CreateEventSegue":
            let createeventViewController = segue.destinationViewController as! CreateEventViewController
            createeventViewController.user = user
            break
            
        default: print("Uknown Segue!")
    }


    }
}
