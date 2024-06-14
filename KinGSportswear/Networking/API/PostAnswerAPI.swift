//
//  PostAnswerAPI.swift
//  KinGSportswear
//
//  Created by Vinh Dang on 10/29/18.
//  Copyright © 2023 Rikkeisoft. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class PostAnswerAPI: APIOperation<PostAnswerResponse> {
    
    init(content: String) {
        let parameters: Parameters = ["content": content]
        super.init(request: APIRequest(name: "API0002 ▶︎ Post answer",
                                       path: "answers",
                                       method: .post,
                                       parameters: .body(parameters)))
    }
}

struct PostAnswerResponse: APIResponseProtocol {

    // Variable from response data
    var success: Bool?

    init(json: JSON) {
        success = json["success"].bool
    }
}
