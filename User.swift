//
//  User.swift
//  selfiegram
//
//  Created by Andrew Gardhouse on 2016-01-14.
//  Copyright © 2016 Andrew Gardhouse. All rights reserved.
//

import Foundation
import UIKit

class User {
    let username: String
    let profileImage:UIImage
    
    init(username: String, profileImage: UIImage) {
        self.username = username
        self.profileImage = profileImage
    }
}
