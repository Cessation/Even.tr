//
//  CreateEventViewController.swift
//  eventr
//
//  Created by Sagar  on 3/23/16.
//  Copyright © 2016 cessation. All rights reserved.
//

import UIKit

class CreateEventViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var eventTitleField: UITextField!
    @IBOutlet weak var detailsTextField: UITextView!
    @IBOutlet weak var eventImageView: UIView!
    @IBOutlet weak var endDate: UIDatePicker!
    @IBOutlet weak var startDate: UIDatePicker!
    
    
    var finalImage: UIImage!
    var sendingEvent : Event!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gesture = UITapGestureRecognizer(target: self, action: "tapped:")
        eventImageView.addGestureRecognizer(gesture)
        // Do any additional setup after loading the view.


        // Do any additional setup after loading the view.
    }
    
    func tapped(sender:UITapGestureRecognizer){
        print("Tapped")
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        // Get the image captured by the UIImagePickerController
        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        
        finalImage = resize(editedImage, newSize: eventImageView.frame.size)
        
        // Do something with the images (based on your use case)
        eventImageView.backgroundColor = UIColor(patternImage: finalImage)
        
        // Dismiss UIImagePickerController to go back to your original view controller
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func resize(image: UIImage, newSize: CGSize) -> UIImage {
        let resizeImageView = UIImageView(frame: CGRectMake(0, 0, newSize.width, newSize.height))
        resizeImageView.contentMode = UIViewContentMode.ScaleAspectFill
        resizeImageView.image = image
        
        UIGraphicsBeginImageContext(resizeImageView.frame.size)
        resizeImageView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    @IBAction func onSubmit(sender: AnyObject) {
        //store and upload data onto events page
        //error checking
        print(eventTitleField.text)
//        sendingEvent.title = eventTitleField.text as? NSString
//        sendingEvent?.title = eventTitleField.text
//        sendingEvent?.desc = detailsTextField.text
//        sendingEvent?.picture = finalImage
//        sendingEvent?.startTime = startDate.date
//        sendingEvent?.endTime = endDate.date
//        sendingEvent?.hashtags = [""]
//        sendingEvent?.author = "blank"
//        sendingEvent?.eventId = "yo"
//        print(sendingEvent)
//        ParseEvent.postUserEvent(sendingEvent!) { (success:Bool, error:NSError?) -> Void in
//            if success {
//                print("image saved")
//                self.navigationController?.popViewControllerAnimated(true)
//            }
//            else{
//                print(error?.localizedDescription)
//            }
//            
//        }
        
        ParseEvent.postUserEvent(eventTitleField.text!, desc: detailsTextField.text!, picture: finalImage!) { (success: Bool, error: NSError?) in
                        if success {
                            print("event saved")
                        }
                        else{
                            print(error?.localizedDescription)
                        }
        }
//        ParseEvent.postUserEvent(sendingEvent) { (success:Bool, error:NSError?) -> Void in
//            if success {
//                print("image saved")
//                self.navigationController?.popViewControllerAnimated(true)
//            }
//            else{
//                print(error?.localizedDescription)
//            }
//            
//        }
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
