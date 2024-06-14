//
//  NetworkDispatcher.swift
//  KinGSportswear
//
//  Created by Vinh Dang on 12/7/18.
//  Copyright © 2018 Rikkeisoft. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class APIDispatcher: APIDispatcherProtocol {
    // Singleton variable for using default network enviroment
    //static var shared = NetworkDispatcher(enviroment: APIEnviroment.default)
    
    // MARK: - Variables
    weak var target: UIViewController?
    private var request: APIRequest?
    
    // MARK: - Init & deinit
    init() {
        APIProcessingManager.instance.add(dispatcher: self)
    }
    
    // MARK: - Request API task
    private var dataRequest: DataRequest?
    private var uploadRequest: UploadRequest?
    
    func execute(request: APIRequest, completed: @escaping ((_ response: APIResponse) -> Void)) {
        self.request = request
        // Check case of request's parameters
        switch request.parameters {
        case .body:
            let urlRequest = prepareBodyFor(request: request)
            self.dataRequest = AF.request(urlRequest).responseJSON(completionHandler: { [weak self] response in
                guard let sSelf = self else { return }
                completed(APIResponse(response, fromRequest: request))
                APIProcessingManager.instance.removeDispatcherFromList(dispatcher: sSelf)
                print("▶︎ [API Processing Manager] Removed body request from list for screen: \(sSelf.target?.name ?? "none") !")
            })
        case .raw(let text):
            guard let rawRequest = prepareRawFor(request: request, rawText: text) else {
                completed(APIResponse.error(APIError.unknown))
                return
            }
            self.dataRequest = AF.request(rawRequest).responseJSON(completionHandler: { [weak self] data in
                guard let sSelf = self else { return }
                completed(APIResponse(data, fromRequest: request))
                APIProcessingManager.instance.removeDispatcherFromList(dispatcher: sSelf)
                print("▶︎ [API Processing Manager] Removed raw request from list for screen: \(sSelf.target?.name ?? "none") !")
            })
        case .multipart(let data, let parameters, let name, let fileName, let mimeType):
            let fullHttpHeaders = prepareHeadersForMultipartOrBinary(request: request)
            
            self.uploadRequest = AF.upload(multipartFormData: { (multipartFormData) in
                for (key, value) in parameters {
                    if let valueData = "\(value)".data(using: String.Encoding.utf8) {
                        multipartFormData.append(valueData, withName: key as String)
                    }
                }
                if let data = data {
                    multipartFormData.append(data, withName: name, fileName: fileName, mimeType: mimeType)
                }
            }, to: request.asFullUrl, usingThreshold: UInt64(), method: request.method , headers: fullHttpHeaders).responseJSON { [weak self](response) in
                guard let sSelf = self else { return }
                completed(APIResponse(response, fromRequest: request))
                APIProcessingManager.instance.removeDispatcherFromList(dispatcher: sSelf)
                print("▶︎ [API Processing Manager] Removed multipart request from list for screen: \(sSelf.target?.name ?? "none") !")
            }
        case .binary( let data):
            let fullHttpHeaders = prepareHeadersForMultipartOrBinary(request: request)
            self.uploadRequest = AF.upload(data, to: request.asFullUrl, method: request.method, headers: fullHttpHeaders).responseJSON { [weak self] response in
                guard let sSelf = self else { return }
                completed(APIResponse(response, fromRequest: request))
                APIProcessingManager.instance.removeDispatcherFromList(dispatcher: sSelf)
                print("▶︎ [API Processing Manager] Removed binary request from list for screen: \(sSelf.target?.name ?? "none") !")
            }
        }
    }
    
    // MARK: - Cancel api task
    func cancel() {
        if let dataRequest = self.dataRequest {
            dataRequest.cancel()
            self.dataRequest = nil
        }
        if let uploadRequest = self.uploadRequest {
            uploadRequest.cancel()
            self.uploadRequest = nil
        }
        APIProcessingManager.instance.removeDispatcherFromList(dispatcher: self)
    }
}

// MARK: - Prepare input data for requests
extension APIDispatcher {
    func prepareBodyFor(request: APIRequest) -> URLRequestConvertible {
        return ConvertibleRequest(request: request)
    }
    
    func prepareRawFor(request: APIRequest, rawText: String) -> URLRequest? {
        // Request url
        let enviroment = request.enviroment
        guard let url = URL(string: request.asFullUrl) else { return nil }
        var urlRequest = URLRequest(url: url)
        urlRequest.cachePolicy = .reloadIgnoringCacheData
        
        // Method
        urlRequest.httpMethod = request.method.rawValue
        
        // Timeout interval
        urlRequest.timeoutInterval = enviroment.timeout
        
        // Http headers
        request.asFullHttpHeaders.forEach {
            urlRequest.setValue($0.value, forHTTPHeaderField: $0.name)
        }
        
        // Raw text
        guard let textData = rawText.data(using: .utf8, allowLossyConversion: false) else { return nil }
        urlRequest.httpBody = textData
        
        // Return result
        return urlRequest
    }
    
    func prepareHeadersForMultipartOrBinary(request: APIRequest) -> HTTPHeaders {
        return request.asFullHttpHeaders
    }
}

struct ConvertibleRequest: URLRequestConvertible {
    
    private var request: APIRequest
    
    init(request: APIRequest) {
        self.request = request
    }
    
    func asURLRequest() throws -> URLRequest {
        // Request url
        let enviroment = request.enviroment
        var urlRequest = URLRequest(url: URL(string: request.asFullUrl)!)
        urlRequest.cachePolicy = .reloadIgnoringCacheData
        
        // Method
        urlRequest.httpMethod = request.method.rawValue
        
        // Timeout interval
        urlRequest.timeoutInterval = enviroment.timeout
        
        // Http headers
        request.asFullHttpHeaders.forEach {
            urlRequest.setValue($0.value, forHTTPHeaderField: $0.name)
        }
        
        // Parameters
        var parameters: Parameters = [:]
        switch request.parameters {
        case .body(let params):
            parameters = params
        default:
            break
        }
        
        // Return result
        return try enviroment.encoding.encode(urlRequest, with: parameters)
    }
}
