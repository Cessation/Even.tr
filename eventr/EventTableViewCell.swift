//
//  EventTableViewCell.swift
//  eventr
//
//  Created by Sagar  on 3/24/16.
//  Copyright © 2016 cessation. All rights reserved.
//

import UIKit
import Parse

class EventTableViewCell: UITableViewCell {
    
    @IBOutlet weak var attendeesLabel: UILabel!
    @IBOutlet weak var eventDateLabel: UILabel!
    @IBOutlet weak var eventTimeLabel: UILabel!
    @IBOutlet weak var eventTitleLabel: UILabel!
    @IBOutlet weak var eventImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var title: String? {
        didSet {
            eventTitleLabel.text = title
        }
    }
    
    // pass in the start and end date
    var date: [String]? {
        didSet {
            if (date![0] == date![1]) {
                
                eventTimeLabel.text = date![0]
                
            } else {
                
                eventTimeLabel.text = date![0] + " - " + date![1]
            }
        }
    }
    
    var time: [String]? {
        didSet {
            
            eventTimeLabel.text = time![0] + " - " + time![1]
        }
    }
    
    var postPic: PFFile! {
        didSet {
            postPic?.getDataInBackgroundWithBlock({ (data: NSData?, error: NSError?) -> Void in
                if error == nil {
                    self.eventImage.image = UIImage(data: data!)!
                }
                else {
                    print("error")
                }
            })
        }
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
