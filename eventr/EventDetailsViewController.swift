//
//  EventDetailsViewController.swift
//  eventr
//
//  Created by Sagar  on 3/27/16.
//  Copyright © 2016 cessation. All rights reserved.
//

import UIKit

class EventDetailsViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var eventImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var attendeeButton: UIButton!
    @IBOutlet weak var creatorButton: UIButton!
    
    var event: Event!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = event.title
        dateLabel.text = "\(event.startDate!) - \(event.endDate!)"
        timeLabel.text = "\(event.startTime!) - \(event.endTime!)"
//        eventImageView.image = event.picture
        descriptionLabel.text = event.desc as! String
//        attendeeLabel.text = "\(event.attendees) Attending"
        attendeeButton.setTitle("\(event.attendees) Attending", forState: .Normal)
        creatorButton.setTitle("Created by: \(event.author)", forState: .Normal)


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
