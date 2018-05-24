//
//  MovieManager.swift
//  Movies
//
//  Created by Olha Salii on 5/17/18.
//  Copyright © 2018 Olha Salii. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

public class MovieManager {
    
    // Can't init singleton
    private init() { }
    
    // MARK: Shared Instance
    static let shared = MovieManager()
    
    let service = DataStore.shared.dataService
    
    func getMovieDetails(for movie: Movie, completionHandler: @escaping (Movie, Error?) -> Void) {
        service.getMovieDetails(by: movie.id) { data, error in
            if error != nil {
                completionHandler(movie, error)
            } else {
                if let unwrappedData = data {
                    let json = JSON(unwrappedData)
                    let updatedMovie = movie
                    updatedMovie.fillAdditionalInfo(json)
                    completionHandler(updatedMovie, nil)
                } else {
                    completionHandler(movie, nil)
                }
            }
        }
    }
    
    func getPoster(for movie: Movie, size: posterSize, completionHandler: @escaping (UIImage?, Error?) -> Void) {
        service.getMoviePoster(by: movie.posterPath, size: size) { image, error in
            completionHandler(image, error)
        }
    }
      
    func getMoviesAndPosters(by query: String, completionHandler: @escaping ([Movie : UIImage]?, Error?) -> Void) {
        var result = [Movie : UIImage]()
        
        getListOfMovies(by: query) {[weak self] moviesData, error in
            if error != nil {
                completionHandler(nil, error)
            } else {
                if let movies = moviesData {
                    let group = DispatchGroup()
                    for movie in movies {
                         group.enter()
                        self?.getPoster(for: movie, size: .medium, completionHandler: { data, _ in
                            if let image = data {
                                result.updateValue(image, forKey: movie)
                            } else {
                                result.updateValue(#imageLiteral(resourceName: "not-available"), forKey: movie)
                            }
                            group.leave()
                        })
                    }
                    group.notify(queue: .main) {
                        completionHandler(result, nil)
                    }
                }
            }
        }
    }
    
    func getListOfMovies(by query: String, completionHandler: @escaping (Array<Movie>?, Error?) -> Void) {
        service.getSearchMovie(by: query) { data, error in
            if error != nil {
                completionHandler(nil, error)
            } else {
                var arrayOfMovies : Array<Movie> = Array()
                if let unwrappedData = data {
                    let json = JSON(unwrappedData)
                    for subItem in json["results"] {
                        arrayOfMovies.append(Movie.init(subItem.1))
                    }
                    completionHandler(arrayOfMovies, nil)
                } else {
                    completionHandler(nil, nil)
                }
            }
        }
    }
}
