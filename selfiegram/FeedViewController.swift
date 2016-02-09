//
//  FeedViewController.swift
//  selfiegram
//
//  Created by Andrew Gardhouse on 2016-01-19.
//  Copyright © 2016 Andrew Gardhouse. All rights reserved.
//

import UIKit
import Parse

class FeedViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var posts = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let query = Post.query() {
            query.orderByDescending("createdAt")
            query.includeKey("user")
            query.findObjectsInBackgroundWithBlock({ (posts, err) -> Void in
                if ((err) != nil) {
                    print(err)
                } else {
                    if let posts = posts as? [Post] {
                        self.posts = posts
                        self.tableView.reloadData()
                    }
                }
            })
        }
        
//        let task = NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: "https://www.flickr.com/services/rest/?method=flickr.photos.search&format=json&nojsoncallback=1&api_key=e33dc5502147cf3fd3515aa44224783f&tags=rapbattle")!) { (data, response, error) -> Void in
//            
//            if let jsonUnformatted = try? NSJSONSerialization.JSONObjectWithData(data!, options: []),
//                let json = jsonUnformatted as? [String : AnyObject],
//                let photosDictionary = json["photos"] as? [String : AnyObject],
//                let photosArray = photosDictionary["photo"] as? [[String : AnyObject]] {
//                    for photo in photosArray {
//                        let farmId = photo["farm"] as! Int
//                        let serverId = photo["server"] as! String
//                        let photoId = photo["id"] as! String
//                        let photoSecret = photo["secret"] as! String
//                        let photoTitle = photo["title"] as! String
//                        
//                        let photoURLString = "https://farm\(farmId).staticflickr.com/\(serverId)/\(photoId)_\(photoSecret).jpg"
//                        
//                        if let photoURL = NSURL(string: photoURLString) {
//                            let me = User(username: "Andrew", profileImage: UIImage(named: "grumpy-cat")!)
//                            let post = Post(imageUrl: photoURL, user: me, comment: photoTitle)
//                            self.posts.append(post)
//                        }
//                        
//                    }
//                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
//                        self.tableView.reloadData()
//                    })
//            } else {
//                print("No data here")
//            }
//            
//        }
        
        // this is called to start (or restart, if needed) our task
//        task.resume()
        
        //        let post0 = Post(image: UIImage(named: "grumpy-cat")!, user: me, comment: "Grumpy Cat 1")
        //        let post1 = Post(image: UIImage(named: "grumpy-cat")!, user: me, comment: "Grumpy Cat 2")
        //        let post2 = Post(image: UIImage(named: "grumpy-cat")!, user: me, comment: "Grumpy Cat 3")
        //        let post3 = Post(image: UIImage(named: "grumpy-cat")!, user: me, comment: "Grumpy Cat 4")
        //        let post4 = Post(image: UIImage(named: "grumpy-cat")!, user: me, comment: "Grumpy Cat 5")
        
        //        posts = [post0, post1, post2, post3, post4]
        
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
        
        cell.post = post
        
        return cell
    }
    
        func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
            
            if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
                
                // setting the compression quality to 90%
                if let imageData = UIImageJPEGRepresentation(image, 0.9),
                    let imageFile = PFFile(data: imageData),
                    let user = PFUser.currentUser(){
                        
                        //2. We create a Post object from the image
                        let post = Post(image: imageFile, user: user, comment: "A Selfie")
                        
                        post.saveInBackgroundWithBlock({ (success, error) -> Void in
                            if success {
                                print("Post successfully saved in Parse")
                                
                                //3. Add post to our posts array, chose index 0 so that it will be added
                                //   to the top of your table instead of at the bottom (default behaviour)
                                self.posts.insert(post, atIndex: 0)
                                
                                //4. Now that we have added a post, updating our table
                                //   We are just inserting our new Post instead of reloading our whole tableView
                                //   Both method would work, however, this gives us a cool animation for free
                                
                                let indexPath =  NSIndexPath(forRow: 0, inSection: 0)
                                self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
                                
                            }
                        })
                }
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
