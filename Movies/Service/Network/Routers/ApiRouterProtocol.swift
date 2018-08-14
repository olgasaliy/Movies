//
//  ApiRouterProtocol.swift
//  Movies
//
//  Created by Olga Saliy on 8/14/18.
//  Copyright © 2018 Olha Salii. All rights reserved.
//

import Foundation

import Foundation
import Alamofire

protocol ApiRouterProtocol: URLRequestConvertible {
    
    /// Router URL.
    var urlPath: URL { get }
    
    /// Path added to base url
    var path: String { get }
    
    /// HTTP method.
    var method: HTTPMethod { get }
    
    /// List of parameters for request (depends on http method)
    var parameters: Parameters { get }
    
    /// Request body.
    var body: String? { get }
    
    /// Request headers.
    var headers: [String: String] { get }
    
}

// MARK: - Default implementation for protocol
extension ApiRouterProtocol {
    
    var urlPath: URL {
        return URL(fileURLWithPath: "https://api.themoviedb.org/3")
    }
    
    private var apiKey: (String, String) {
        return ("api_key", "f04e8ed93af390cef2ecddaf78379d66")
    }
    
    var body: String? {
        return nil
    }
    
    var parameters: Parameters {
        return [:]
    }
    
    private var allParameters: Parameters{
        var map = parameters
        map[apiKey.0] = apiKey.1
        return map
    }
    
    var headers: [String: String] {
        return [:]
    }
    
    private var defaultHeaders: [String: String] {
        return ["Accept": "application/json",
                "Content-Type": "application/json"]
    }
    
    private var allHeaders: [String: String] {
        var map = defaultHeaders
        for (key, value) in headers {
            map[key] = value
        }
        return map
    }
    
    func asURLRequest() throws -> URLRequest {
        var urlRequest = try URLRequest(url: urlPath.appendingPathComponent(path),
                                        method: method,
                                        headers: allHeaders)
        urlRequest = try URLEncoding.default.encode(urlRequest, with: allParameters)
        
        if let body = body?.data(using: String.Encoding.utf8) {
            urlRequest.httpBody = body
        }
        
        return urlRequest
    }
    
}
