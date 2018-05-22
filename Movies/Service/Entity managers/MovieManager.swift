//
//  MovieManager.swift
//  Movies
//
//  Created by Olha Salii on 5/17/18.
//  Copyright © 2018 Olha Salii. All rights reserved.
//

import Foundation

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
        let tempQuery = "best"
        
        service.getSearchMovie(byQuery: tempQuery) { data, error in
            
        }
        
    }
    
}
