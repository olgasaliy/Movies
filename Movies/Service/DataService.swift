//
//  DataService.swift
//  Movies
//
//  Created by Olha Salii on 5/17/18.
//  Copyright © 2018 Olha Salii. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage
import SwiftyJSON

enum posterSize: String {
    case original = "original"
    case big = "w500"
    case medium = "w185"
    case small = "w92"
}

public class DataService{

    let sessionManager: SessionManager
    let baseURL: String
    var imageBaseURL: String?
    
    var apiKey: [String : String]
    
    init(withBaseUrl url: String, apiKey: String) {
        self.sessionManager = SessionManager(configuration: URLSessionConfiguration.default)
        self.baseURL = url
        self.apiKey = ["api_key" : apiKey]
        configureAPI()
    }
    
    private func configureAPI() {
        //download imageURL
        var path = "\(baseURL)/configuration"
        let params = generateParameters(from: [String : String]())
        
        sessionManager.request(path, parameters: params).validate(statusCode: 100..<405).responseJSON { [weak self] response in
            if let data = response.result.value {
                let json = JSON(data)
                self?.imageBaseURL = json["images"]["secure_base_url"].string
            }
        }
        
        path += "/languages"
        getLanguages(by: path) { (response, _) in
            if let data = response {
                let json = JSON(data)
                for item in json.arrayValue {
            Languages.shared.dictionary.updateValue(item["english_name"].stringValue, forKey: item["iso_639_1"].stringValue)
                }
            }
        }
    }
    
    // MARK: - Helpers
    
    private func generateParameters(from params: [String : Any]) -> [String : Any] {
        return params.merging(apiKey) { (current, _) in current }
    }
    
    private func makeJSONRequest(with path: String,
                             _ params: [String : Any],
                             _ completionHanler: @escaping (Any?, Error?) -> Void ) {
        sessionManager.request(path, parameters: params).validate(statusCode: 100..<405).responseJSON { response in
            switch response.result {
            case .success:
                completionHanler(response.result.value, nil)
            case .failure(let error):
                completionHanler(nil, error)
            }
        }
    }
    
    private func makeImageRequest(with path: String,
                                 _ params: [String : Any],
                                 _ completionHanler: @escaping (Image?, Error?) -> Void ) {
        sessionManager.request(path, parameters: params).validate(statusCode: 100..<405).responseImage { response in
            switch response.result {
            case .success:
                completionHanler(response.result.value, nil)
            case .failure(let error):
                completionHanler(nil, error)
            }
        }
    }
    
    //MARK: - Movie
    
    func getSearchMovie(by query: String, completionHanler: @escaping (Any?, Error?) -> Void ) {
        let path = "\(baseURL)/search/movie"
        let params = generateParameters(from: ["query" : query])
        
        makeJSONRequest(with: path, params, completionHanler)
    }
    
    func getMovieDetails(by id: Int, completionHanler: @escaping (Any?, Error?) -> Void ) {
        let path = "\(baseURL)/search/movie"
        let params = generateParameters(from: ["movie_id" : id])
        
        makeJSONRequest(with: path, params, completionHanler)
    }
    
    //MARK: - Movie poster
    
    func getMoviePoster(by url: String, size: posterSize, completionHanler: @escaping (Image?, Error?) -> Void ) {
        guard let imageURL = imageBaseURL else { completionHanler(nil, nil); return }
        
        let path = "\(imageURL)\(size.rawValue)\(url)"
        let params = generateParameters(from: [String : String]())

        makeImageRequest(with: path, params, completionHanler)
    }
    
    //MARK: - Languages
    
    private func getLanguages(by url: String, completionHanler: @escaping (Any?, Error?) -> Void ) {
        
        let path = url
        let params = generateParameters(from: [String : String]())
        
        makeJSONRequest(with: path, params, completionHanler)
    }
    
}
