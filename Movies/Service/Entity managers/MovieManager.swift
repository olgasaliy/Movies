//
//  MovieManager.swift
//  Movies
//
//  Created by Olha Salii on 5/17/18.
//  Copyright © 2018 Olha Salii. All rights reserved.
//

import Foundation
import SwiftyJSON

public class MovieManager {
    
    // Can't init singleton
    private init() { }
    
    // MARK: Shared Instance
    static let shared = MovieManager()
    
    let service = DataStore.shared.dataService
    
    func getMovie(byID id:Int, completionHandler: @escaping (Movie?, Error?) -> Void) {

    }
    
    func getListOfMovies(byQuery query:String, completionHandler: @escaping (Array<Movie>?, Error?) -> Void) {
        //TEMP
        service.getSearchMovie(byQuery: query) { data, error in
            if let unwrappedError = error {
                
            } else {
                var array:Array<Movie> = Array()
                if let unwrappedData = data {
                    let json = JSON(unwrappedData)
                    for (index, subJSON) : (String, JSON) in json["results"] {
                        array.append(Movie.init(subJSON.dictionaryObject!))
                    }
                    
                }
            }
        }
        
    }
    
}
