//
//  FeedViewController.swift
//  selfiegram
//
//  Created by Andrew Gardhouse on 2016-01-19.
//  Copyright © 2016 Andrew Gardhouse. All rights reserved.
//

import UIKit

class FeedViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var posts = [Post]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let me = User(username: "Andrew", profileImage: UIImage(named: "grumpy-cat")!)
        let post0 = Post(image: UIImage(named: "grumpy-cat")!, user: me, comment: "Grumpy Cat 1")
        let post1 = Post(image: UIImage(named: "grumpy-cat")!, user: me, comment: "Grumpy Cat 2")
        let post2 = Post(image: UIImage(named: "grumpy-cat")!, user: me, comment: "Grumpy Cat 3")
        let post3 = Post(image: UIImage(named: "grumpy-cat")!, user: me, comment: "Grumpy Cat 4")
        let post4 = Post(image: UIImage(named: "grumpy-cat")!, user: me, comment: "Grumpy Cat 5")
        
        posts = [post0, post1, post2, post3, post4]

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return posts.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("postCell", forIndexPath: indexPath) as! SelfieCell
        
        let post = posts[indexPath.row]
        cell.selfieImageView.image = post.image
        cell.usernameLabel.text = post.user.username
        cell.commentLabel.text = post.comment

        return cell
    }

    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        // 1. When the delegate method is returned, it passes along a dictionary called info.
        //    This dictionary contains multiple things that maybe useful to us.
        //    We are getting an image from the UIImagePickerControllerOriginalImage key in that dictionary
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            //2. We create a Post object from the image
            let me = User(username: "Andrew", profileImage: UIImage(named: "grumpy-cat")!)
            let post = Post(image: image, user: me, comment: "My Selfie")
            
            //3. Add post to our posts array
            //    Adds it to the very top of our array (and therefore our table, when we pi
            posts.insert(post, atIndex: 0)
            
        }
        
        //4. We remember to dismiss the Image Picker from our screen.
        dismissViewControllerAnimated(true, completion: nil)
        
        //5. Now that we have added a post, reload our table
        tableView.reloadData()
        
    }

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

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
