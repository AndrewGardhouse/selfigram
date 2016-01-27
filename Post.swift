//
//  Post.swift
//  selfiegram
//
//  Created by Andrew Gardhouse on 2016-01-14.
//  Copyright © 2016 Andrew Gardhouse. All rights reserved.
//

import Foundation
import UIKit

class Post {
    let imageUrl: NSURL
    let comment: String
    let user: User
    
    init(imageUrl: NSURL, user: User, comment: String) {
        self.imageUrl = imageUrl
        self.comment = comment
        self.user = user
    }
}
