//
//  Answer.swift
//  KinGSportswear
//
//  Created by Vinh Dang on 10/23/18.
//  Copyright © 2023 Rikkeisoft. All rights reserved.
//

import UIKit
import SwiftyJSON

class Answer {
    var owner: Owner?
    var isAccepted: Bool?
    var score: Int?
    var lastActivityDate: Int?
    var creationDate: Int?
    var answerId: Int?
    var questionId: Int?
    
    init() { }
    
    init(json: JSON) {
        owner = Owner(json: json["owner"])
        isAccepted = json["is_accepted"].bool
        score = json["score"].int
        lastActivityDate = json["last_activity_date"].int
        creationDate = json["creation_date"].int
        answerId = json["answer_id"].int
        questionId = json["question_id"].int
    }
}
