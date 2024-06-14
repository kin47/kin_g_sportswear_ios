//
//  MainEnviroment.swift
//  KinGSportswear
//
//  Created by Vinh Dang on 2/18/19.
//  Copyright © 2023 Rikkeisoft. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class APIMainEnviroment: APIEnviromentProtocol {
    
    static var `default`: APIMainEnviroment {
        return APIMainEnviroment(baseUrl: APIConfiguration.baseUrl,
                             headers: APIConfiguration.httpHeaders,
                             encoding: APIConfiguration.encoding,
                             timeout: APIConfiguration.timeout)
    }
    
    static var jsonEnviroment: APIMainEnviroment {
        return APIMainEnviroment(baseUrl: APIConfiguration.baseUrl,
                             headers: APIConfiguration.bearerHeader,
                             encoding: JSONEncoding.default,
                             timeout: APIConfiguration.timeout)
    }
    
    // Base URL of the enviroment (default is base url of current scheme)
    var baseUrl: String
    
    // HTTP headers of the enviroment (default is headers of current scheme)
    var headers: HTTPHeaders
    
    // URL encoding of the enviroment (default is Encoding Default type)
    var encoding: ParameterEncoding
    
    // Request timeout for request
    var timeout: TimeInterval
    
    // MARK: - Init
    init(baseUrl: String, headers: HTTPHeaders, encoding: ParameterEncoding, timeout: TimeInterval) {
        self.baseUrl = baseUrl
        self.headers = headers
        self.encoding = encoding
        self.timeout = timeout
    }
    
    func parseApiErrorJson(_ json: JSON, statusCode: Int?) -> APIError? {
        // Try to parse input json to error class according to your error json format
        // Example:
        guard let errorId = json["error_id"].int else { return nil }
        let errorMessage = json["error_message"].string
        return APIError.api(statusCode: statusCode,
                            apiCode: errorId,
                            message: errorMessage)
    }
    
    // MARK: - Builder
    @discardableResult
    func set(baseUrl: String) -> APIMainEnviroment {
        self.baseUrl = baseUrl
        return self
    }
    
    @discardableResult
    func set(headers: HTTPHeaders) -> APIMainEnviroment {
        self.headers = headers
        return self
    }
    
    @discardableResult
    func set(encoding: ParameterEncoding) -> APIMainEnviroment {
        self.encoding = encoding
        return self
    }
    
    @discardableResult
    func set(timeout: TimeInterval) -> APIMainEnviroment {
        self.timeout = timeout
        return self
    }
}
