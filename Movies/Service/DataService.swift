//
//  DataService.swift
//  Movies
//
//  Created by Olha Salii on 5/17/18.
//  Copyright © 2018 Olha Salii. All rights reserved.
//

import Foundation
import Alamofire

enum posterSizes: String {
    case original = "original"
    case big = "w500"
    case medium = "w185"
    case small = "w92"
}

public class DataService{

    let sessionManager: SessionManager
    let baseURL: URL
    var imageBaseURL: URL?
    
    var apiKey: (name: String, key: String)
    
    init(withBaseUrl url: URL, apiKey: String) {
        self.sessionManager = SessionManager(configuration: URLSessionConfiguration.default)
        self.baseURL = url
        self.apiKey = ("api_key", apiKey)
    }
    
    func getSearchMovie(byQuery query: String, completionHanler: @escaping (Data?, Error?) -> Void ) {
        let path = "\(baseURL)/search/movie/"
        let params = [
            apiKey.name : apiKey.key,
            "query" : query
        ]
        
        sessionManager.request(path, parameters: params).validate(statusCode: 100..<405).responseData { response in
            switch response.result {
            case .success:
                completionHanler(response.data, nil)
            case .failure(let error):
                completionHanler(nil, error)
            }
        }
    }
    
}