//
//  ProfileViewController.swift
//  eventr
//
//  Created by Sagar  on 3/27/16.
//  Copyright © 2016 cessation. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var detailsField: UITextView!
    
    var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = user.firstName! + " " + user.lastName!
        detailsField.text = user.details
        //add profile image
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
