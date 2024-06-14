//
//  UploadAvatarAPI.swift
//  KinGSportswear
//
//  Created by Vinh Dang on 12/7/18.
//  Copyright © 2023 Rikkeisoft. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class UploadAvatarAPI: APIOperation<UploadAvatarResponse> {
    
    init(base64data: Data) {
        super.init(request: APIRequest(name: "API0003 ▶︎ Upload avatar",
                                       path: "user/info",
                                       method: .post,
                                       parameters: .multipart(data: base64data,
                                                              parameters: [:],
                                                              name: "image",
                                                              fileName: "image.png",
                                                              mimeType: "image/png")))
    }
}

struct UploadAvatarResponse: APIResponseProtocol {
    
    // Variable from response data
    var success: Bool?
    
    init(json: JSON) {
        success = json["success"].bool
    }
}
