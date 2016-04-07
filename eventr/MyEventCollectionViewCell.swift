//
//  MyEventCollectionViewCell.swift
//  eventr
//
//  Created by Sagar  on 4/6/16.
//  Copyright © 2016 cessation. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class MyEventCollectionViewCell: UICollectionViewCell {
   
    @IBOutlet weak var eventImage: PFImageView!
  
    @IBOutlet weak var eventTitle: UILabel!
    
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

    
    
}
