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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidAppear(animated: Bool) {
        print("View did appear")
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
    
    //Uncomment cell.date... and cell.time... when the Heruko backend has been cleaned!!!
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
        cell.attendeesLabel.text = "- 0"
        return cell
        
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if events != nil {
            return events!.count
        } else {
            return 0
        }
    }
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
