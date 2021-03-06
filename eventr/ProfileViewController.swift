//
//  ProfileViewController.swift
//  eventr
//
//  Created by Sagar  on 3/27/16.
//  Copyright © 2016 cessation. All rights reserved.
//

import UIKit
import AFNetworking
import Parse

class ProfileViewController: UIViewController, UITextViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate {

   
    @IBOutlet weak var eventsCollectionView: UICollectionView!
    @IBOutlet weak var myeventsCollectionView: UICollectionView!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var detailsField: UITextView!
    
    var email: String?
    var oldDetailText: String?
    var newDetailText: String?
    var events: [String]?
    var myevents:[String]?
    var user: PFObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        let query = PFQuery(className: "User")
        query.whereKey("email", equalTo: email!)
        query.findObjectsInBackgroundWithBlock { (users: [PFObject]?, error: NSError?) -> Void in
        
        self.eventsCollectionView.delegate = self
        self.eventsCollectionView.dataSource = self
        self.myeventsCollectionView.delegate = self
        self.myeventsCollectionView.dataSource = self
        self.user = users!.first
        self.nameLabel.text = (self.user!["firstName"] as? String)! + (self.user!["lastName"] as? String)!
        self.detailsField.text = self.user!["details"] as? String
         self.profileImage.setImageWithURL(NSURL(string: (self.user!["profileImage"] as? String)!)!)
        self.detailsField.userInteractionEnabled = false
        self.detailsField.delegate = self
        if(self.detailsField.text == ""){
            self.detailsField.text = "Write something about yourself here..."
            self.detailsField.textColor = UIColor.lightGrayColor()
            }
        
        self.view.backgroundColor = UIColor(red:0.76, green:0.96, blue:1.00, alpha:1.0)
        self.events = self.user!["events"] as? [String]
        self.myevents = self.user!["myevents"] as? [String]
        //print(self.myevents)
        
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func textViewDidBeginEditing(textView: UITextView) {
        if textView.textColor == UIColor.lightGrayColor() {
            textView.text = nil
            textView.textColor = UIColor.blackColor()
        }
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Write something about yourself here..."
            textView.textColor = UIColor.lightGrayColor()
        }
    }

    
    @IBAction func onEdit(sender: AnyObject) {
        if (editButton.currentTitle == "Edit")
        {
            editButton.setTitle("Done", forState: .Normal)
            detailsField.layer.borderWidth = 1.5
            detailsField.userInteractionEnabled = true
            oldDetailText = detailsField.text
        }
        else {
            newDetailText = detailsField.text
            view.endEditing(true)
            detailsField.userInteractionEnabled = false
            detailsField.layer.borderWidth = 0
            editButton.setTitle("Edit", forState: .Normal)
            
            if(oldDetailText != newDetailText)
            {
                //update information onto parse!
               
                user!["details"] = newDetailText
                user?.saveInBackground()

            }
        }
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        
        if(collectionView == eventsCollectionView){
            if let events = events {
                return events.count
            } else {
                return 0
            }
        } else {
            
            if let myevents = myevents {
                return myevents.count
            } else {
                return 0
            }
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell{
        
        if (collectionView == eventsCollectionView) {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("EventCell", forIndexPath: indexPath) as! EventCollectionViewCell
            let eventid = events![indexPath.row]
            let query = PFQuery(className: "Event")
            query.whereKey("id", equalTo: eventid)
            query.findObjectsInBackgroundWithBlock { (events: [PFObject]?, error: NSError?) -> Void in
                
                let event = events!.first
                cell.postPic = event!["picture"] as? PFFile
                cell.eventTitle.text = event!["title"] as? String
                
            }
    
            return cell
        } else {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MyEventCell", forIndexPath: indexPath) as! MyEventCollectionViewCell
            let eventid = myevents![indexPath.row]
            let query = PFQuery(className: "Event")
            query.whereKey("id", equalTo: eventid)
            query.findObjectsInBackgroundWithBlock { (events: [PFObject]?, error: NSError?) -> Void in
                
                let event = events!.first
                cell.postPic = event!["picture"] as? PFFile
                cell.eventTitle.text = event!["title"] as? String
                print(event!["title"] as? String)
                
            }

            return cell
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


