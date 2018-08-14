//
//  DataProvider.swift
//  Movies
//
//  Created by Olga Saliy on 8/14/18.
//  Copyright © 2018 Olha Salii. All rights reserved.
//

import Foundation
import ObjectMapper
import Alamofire
import AlamofireObjectMapper

class DataProvider {
    
    private let sessionManager: SessionManager

    init(_ sessionManager: SessionManager) {
        self.sessionManager = sessionManager
    }
    
    func execute<T : Mappable>(request: URLRequestConvertible, completion: @escaping (_ response: T?, _ error: Error?) -> ()) {
        sessionManager.request(request).validate().responseObject { (response: DataResponse<T>) in
            completion(response.result.value, response.result.error)
        }
    }
    
    func execute<T : Mappable>(request: URLRequestConvertible, completion: @escaping (_ response: [T]?, _ error: Error?) -> ()) {
        sessionManager.request(request).validate().responseArray { (response: DataResponse<[T]>) in
            completion(response.result.value, response.result.error)
        }
    }
}
