//
//  Owner.swift
//  KinGSportswear
//
//  Created by Vinh Dang on 10/23/18.
//  Copyright © 2023 Rikkeisoft. All rights reserved.
//

import UIKit
import SwiftyJSON

class Owner {
    var reputation: Int?
    var userId: Int?
    var userType: String?
    var profileImage: String?
    var displayName: String?
    var link: String?
    
    init() { }
    
    init(json: JSON) {
        reputation = json["reputation"].int
        userId = json["user_id"].int
        userType = json["user_type"].string
        profileImage = json["profile_image"].string
        displayName = json["display_name"].string
        link = json["link"].string
    }
}
