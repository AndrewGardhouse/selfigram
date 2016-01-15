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
    let image: UIImage
    let comment: String
    let user: User
    
    init(image: UIImage, comment: String, user: User) {
        self.image = image
        self.comment = comment
        self.user = user
    }
}
