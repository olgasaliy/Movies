//
//  MoviesDataProvider.swift
//  Movies
//
//  Created by Olga Saliy on 8/16/18.
//  Copyright © 2018 Olha Salii. All rights reserved.
//

import Foundation
import Alamofire

class MoviesDataProvider: DataProvider {
    
    init() {
        let sessionManager = SessionManager(configuration: URLSessionConfiguration.default)
        super.init(sessionManager)
    }
    
    func search(by query: String, completion: @escaping (_ response: [Movie]?, _ error: Error?) -> ()) {
        execute(request: MoviesRouter.search(query: query), completion: completion)
    }
    
    func getDetails(by id: Int, completion: @escaping (_ response: Movie?, _ error: Error?) -> ()) {
        execute(request: MoviesRouter.getDetails(id: id), completion: completion)
    }
}
