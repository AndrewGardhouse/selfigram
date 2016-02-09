//
//  Activity.swift
//  selfiegram
//
//  Created by Andrew Gardhouse on 2016-02-08.
//  Copyright © 2016 Andrew Gardhouse. All rights reserved.
//

import Parse

class Activity: PFObject, PFSubclassing {
   
    @NSManaged var type:String
    @NSManaged var post:Post
    @NSManaged var user:PFUser
    
    static func parseClassName() -> String {
        return "Activity"
    }
    
    convenience init(type:String, post:Post, user:PFUser){
        self.init()
        self.type = type
        self.post = post
        self.user = user
    }

}
