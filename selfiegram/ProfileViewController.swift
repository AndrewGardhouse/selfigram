//
//  ProfileViewController.swift
//  selfiegram
//
//  Created by Andrew Gardhouse on 2016-01-12.
//  Copyright © 2016 Andrew Gardhouse. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        // 1. When the delegate method is returned, it passes along a dictionary called info.
        //    This dictionary contains multiple things that maybe useful to us.
        //    We are getting an image from the UIImagePickerControllerOriginalImage key in that dictionary
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            //2. To our imageView, we set the image property to be the image the user has chosen
            profileImageView.image = image
            
        }
        
        //3. We remember to dismiss the Image Picker from our screen.
        dismissViewControllerAnimated(true, completion: nil)
        
    }

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBAction func cameraButtonPressed(sender: AnyObject) {
        let pickerController = UIImagePickerController()
        
        pickerController.delegate = self
        
        if TARGET_OS_SIMULATOR == 1 {
            pickerController.sourceType = .PhotoLibrary
        } else {
            pickerController.sourceType = .Camera
            pickerController.cameraDevice = .Front
            pickerController.cameraCaptureMode = .Photo
        }
        
        self.presentViewController(pickerController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameLabel.text = "Andrew"
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
