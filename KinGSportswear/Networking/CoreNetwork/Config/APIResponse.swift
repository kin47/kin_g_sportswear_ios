//
//  APIResponse.swift
//  KinGSportswear
//
//  Created by Vinh Dang on 12/7/18.
//  Copyright © 2018 Rikkeisoft. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

// Define response data types for each request
public enum APIResponse {
    case success(_: JSON)
    case error(_: APIError)
    
    init(_ response: AFDataResponse<Any>, fromRequest request: APIRequest) {
        // Get status code
        let statusCode = response.response?.statusCode

        switch response.result {
        case .success(let jsonData):
            let json: JSON = JSON(jsonData)
            if let error = request.enviroment.parseApiErrorJson(json, statusCode: statusCode) {
                self = .error(error)
                return
            }
            
            // Get data successfully
            self = .success(json[request.rootKeyValue])
        case .failure(let error):
            self = .error(APIError.request(statusCode: statusCode, error: error))
        }
    }
}

// Model repsonse protocol based on JSON data (View Controller's layers are able to view this protocol as response data)
public protocol APIResponseProtocol {
    // Set json as input variable
    init(json: JSON)
}
