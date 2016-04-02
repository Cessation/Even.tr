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

class ProfileViewController: UIViewController, UITextViewDelegate {

    
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var detailsField: UITextView!
    
    var email: String?
    var oldDetailText: String?
    var newDetailText: String?
    var events: [PFObject]?
    var myevents:[PFObject]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        let query = PFQuery(className: "User")
        query.whereKey("email", equalTo: email!)
        query.findObjectsInBackgroundWithBlock { (users: [PFObject]?, error: NSError?) -> Void in
            
        let user = users!.first
        self.nameLabel.text = (user!["firstName"] as? String)! + (user!["lastName"] as? String)!
        self.detailsField.text = user!["details"] as? String
         self.profileImage.setImageWithURL(NSURL(string: (user!["profileImage"] as? String)!)!)
        self.detailsField.userInteractionEnabled = false
        self.detailsField.delegate = self
        if(self.detailsField.text == ""){
            self.detailsField.text = "Write something about yourself here..."
            self.detailsField.textColor = UIColor.lightGrayColor()
            }
        
        self.view.backgroundColor = UIColor(red:0.76, green:0.96, blue:1.00, alpha:1.0)
       

        
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
                
//                let query = PFQuery(className: "User")
//                query.whereKey("email", equalTo: user.email!)
//                query.findObjectsInBackgroundWithBlock { (user: [PFObject]?, error: NSError?) -> Void in
//                    
//                    user!["details"] = newDetailText

            }
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


