//
//  MoviesRouter.swift
//  Movies
//
//  Created by Olga Saliy on 8/14/18.
//  Copyright © 2018 Olha Salii. All rights reserved.
//

import Foundation
import Alamofire

enum MoviesRouter: ApiRouterProtocol {
    
    case search(query: String)
    
    case getDetails(id: Int)
    
    var path: String {
        switch self {
        case .search(_):
            return "/search/movie"
        case .getDetails(let id):
            return "/movie/\(id)"
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var parameters: Parameters {
        switch self {
        case .search(let query):
            return ["query" : query]
        default:
            return [:]
        }
    }
}
