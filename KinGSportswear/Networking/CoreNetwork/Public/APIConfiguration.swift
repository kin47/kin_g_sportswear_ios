//
//  APIConfiguration.swift
//  KinGSportswear
//
//  Created by IchNV on 9/22/20.
//  Copyright © 2023 Rikkeisoft. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

// MARK: - Request basic information
class APIConfiguration {
    
    static var baseUrl: String {
        #if PRODUCTION
        // API URL for production
        return "https://api.stackexchange.com/2.2"
        #else
        // API URL for staging
        return "https://api.stackexchange.com/2.2"
        #endif
    }
    
    // User Bearer Authorization Headers
    static var bearerHeader: HTTPHeaders {
        var headers: HTTPHeaders = httpHeaders
        headers["Authorization"] = "Bearer " // + Token
        return headers
    }
    
    // HTTP Headers
    static var httpHeaders: HTTPHeaders {
        return [
            // Content-Type depends on server requirement
            "Content-Type": "application/x-www-form-urlencoded",
        ]
    }
    
    // Main encoding
    static let encoding: ParameterEncoding = URLEncoding.default
    
    // Set default timeout for each request
    static let timeout: TimeInterval = 30
}
