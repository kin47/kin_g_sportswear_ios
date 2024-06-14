//
//  APIEnviromentProtocol.swift
//  KinGSportswear
//
//  Created by Vinh Dang on 2/18/19.
//  Copyright © 2023 Rikkeisoft. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

public protocol APIEnviromentProtocol {
    // MARK: - Variable interfaces
    var baseUrl: String { get }
    var headers: HTTPHeaders { get }
    var encoding: ParameterEncoding { get }
    var timeout: TimeInterval { get }
    
    // MARK: - Function interfaces
    func parseApiErrorJson(_ json: JSON, statusCode: Int?) -> APIError?
}
