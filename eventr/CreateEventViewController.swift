//
//  CreateEventViewController.swift
//  eventr
//
//  Created by Sagar  on 3/23/16.
//  Copyright © 2016 cessation. All rights reserved.
//

import UIKit
import ALCameraViewController
import Parse

class CreateEventViewController: UIViewController, UINavigationControllerDelegate, UIScrollViewDelegate, UITextViewDelegate {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var eventTitleField: UITextField!
    @IBOutlet weak var detailsTextField: UITextView!
    @IBOutlet weak var eventImageView: UIView!
    @IBOutlet weak var endDate: UIDatePicker!
    @IBOutlet weak var startDate: UIDatePicker!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var addPictureLabel: UILabel!
    
    var sDate: String! //start date
    var eDate: String! //end date
    var startTime: String!
    var endTime: String!
    var finalImage: UIImage!
    //var sendingEvent : Event!
    var email: String?
    var user: PFObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let gesture = UITapGestureRecognizer(target: self, action: "tapped:")
        eventImageView.addGestureRecognizer(gesture)
        startDate.minimumDate = NSDate()
        endDate.minimumDate = NSDate()
        scrollView.delegate = self
        scrollView.contentSize = contentView.frame.size
        scrollView.scrollEnabled = true
        
        detailsTextField.delegate = self
        detailsTextField.text = "Event Details"
        detailsTextField.textColor = UIColor.lightGrayColor()
        
        self.view.backgroundColor = UIColor(red:0.76, green:0.96, blue:1.00, alpha:1.0)

    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        let query = PFQuery(className: "User")
        query.whereKey("email", equalTo: email!)
        query.findObjectsInBackgroundWithBlock { (users: [PFObject]?, error: NSError?) -> Void in
        self.user = users!.first
        }
    }
    
    func tapped(sender:UITapGestureRecognizer){
        print("Tapped")
        
        let croppingEnabled = true
        let cameraViewController = ALCameraViewController(croppingEnabled: croppingEnabled) { image in
            // Do something with your image here.
            // If cropping is enabled this image will be the cropped version
            print(image)
            let (img,_) = image
            if img != nil{
                print("before resize")
                self.finalImage = self.resize(img!, newSize: self.eventImageView.frame.size)
                print("after resize")
                self.eventImageView.backgroundColor = UIColor(patternImage: self.finalImage)
                print("Got to complete")
                self.addPictureLabel.hidden=true
            }
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        self.presentViewController(cameraViewController, animated: true, completion: nil)
//        let vc = UIImagePickerController()
//        vc.delegate = self
//        vc.allowsEditing = true
//        vc.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
//        
//        self.presentViewController(vc, animated: true, completion: nil)
    }

//    func imagePickerController(picker: UIImagePickerController,
//                               didFinishPickingMediaWithInfo info: [String : AnyObject]) {
//        // Get the image captured by the UIImagePickerController
//        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
//        let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
//        
//        finalImage = resize(editedImage, newSize: eventImageView.frame.size)
//        
//        // Do something with the images (based on your use case)
//        eventImageView.backgroundColor = UIColor(patternImage: finalImage)
//        
//        // Dismiss UIImagePickerController to go back to your original view controller
//        dismissViewControllerAnimated(true, completion: nil)
//    }
    
//    func tapped(sender:UITapGestureRecognizer){
//        print("Tapped")
//        let vc = UIImagePickerController()
//        vc.delegate = self
//        vc.allowsEditing = true
//        vc.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
//        
//        self.presentViewController(vc, animated: true, completion: nil)
//    }
//    
//    func imagePickerController(picker: UIImagePickerController,
//                               didFinishPickingMediaWithInfo info: [String : AnyObject]) {
//        // Get the image captured by the UIImagePickerController
//        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
//        let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
//        
//        finalImage = resize(editedImage, newSize: eventImageView.frame.size)
//        
//        // Do something with the images (based on your use case)
//        eventImageView.backgroundColor = UIColor(patternImage: finalImage)
//        
//        // Dismiss UIImagePickerController to go back to your original view controller
//        dismissViewControllerAnimated(true, completion: nil)
//    }
    
    // ================== For Text field editing ========================================
    
    
    func textViewDidBeginEditing(textView: UITextView) {
        if textView.textColor == UIColor.lightGrayColor() {
            textView.text = nil
            textView.textColor = UIColor.blackColor()
        }
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Event Details"
            textView.textColor = UIColor.lightGrayColor()
        }
    }
    
    // ================== For Text field editing ========================================
    
    

    
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
    
    
    @IBAction func onStartDateChange(sender: AnyObject) {
        
        endDate.minimumDate = startDate.date
    }
    
    @IBAction func onCancel(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion: {})
    }
   
    @IBAction func onSubmit(sender: AnyObject) {
        
        //converting the datepicker inputs to readable start/end date/time
        if(eventTitleField.text == "") {
            let alert = UIAlertController(title: "Add Event Title!", message: "Please add a title for your event.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        } else  if(locationTextField.text == ""){
            let alert = UIAlertController(title: "Add Location of Event!", message: "Please add the location of your event.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        } else if(detailsTextField.text == "Event Details"){
            let alert = UIAlertController(title: "Add Event Description!", message: "Please add a description of your event. You want people to actually attend, dont you? ;)", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        } else {
        if(finalImage == nil)
        {
            finalImage = UIImage(named: "default_image")
        }
        
        //set the start/end date/time variables in a readable format
        let dateFormatter = NSDateFormatter()
        let timeFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.ShortStyle
        timeFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
        sDate = dateFormatter.stringFromDate(startDate.date)
        startTime = timeFormatter.stringFromDate(startDate.date)
        eDate = dateFormatter.stringFromDate(endDate.date)
        endTime = timeFormatter.stringFromDate(endDate.date)
        
            ParseEvent.postUserEvent(eventTitleField.text!, desc: detailsTextField.text!, picture: finalImage!, startDate: sDate, startTime: startTime, endDate: eDate, endTime: endTime, hashtags: [], author: ((user!["firstName"] as? String)! + " " + (user!["lastName"] as? String)!), id: eventTitleField.text! + email!, location: locationTextField.text!) { (success: Bool, error: NSError?) in
                        if success {
                            print("event saved")
                        }
                        else{
                            print(error?.localizedDescription)
                        }
        }
            var myevents = user!["myevents"] as! [String]
            myevents.append(eventTitleField.text! + email!)
            user!["myevents"] = myevents
            user?.saveInBackground()
            print("done this shit", user)
        
        self.dismissViewControllerAnimated(true, completion:{})
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
    
    
    @IBAction func hideKeyboard(sender: AnyObject) {
        scrollView.endEditing(true)
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
