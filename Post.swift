//
//  Post.swift
//  selfiegram
//
//  Created by Andrew Gardhouse on 2016-01-14.
//  Copyright © 2016 Andrew Gardhouse. All rights reserved.
//

import Parse

class Post : PFObject, PFSubclassing {
    @NSManaged var image: PFFile
    @NSManaged var comment: String
    @NSManaged var user: PFUser
    
    static func parseClassName() -> String {
        return "Post"
    }
    
    convenience init(image: PFFile, user: PFUser, comment: String) {
        self.init()
        self.image = image
        self.comment = comment
        self.user = user
    }
}
