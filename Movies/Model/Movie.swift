//
//  Movie.swift
//  Movies
//
//  Created by Olha Salii on 5/17/18.
//  Copyright © 2018 Olha Salii. All rights reserved.
//

import Foundation

public class Movie {
    
    var id: Int
    var title: String
    var releaseDate: Date
    var posterPath: String?
    var rating: NSNumber?
    var overview: String

    init(id: Int, title: String, releaseDate: Date, posterPath: String?, rating: NSNumber?, overview: String) {
        self.id = id
        self.title = title
        self.releaseDate = releaseDate
        self.posterPath = posterPath
        self.rating = rating
        self.overview = overview
    }
    
    convenience init(_ attributes: [String : Any]) {
        let id = attributes["id"] as! Int
        let title = attributes["title"] as! String
        let releaseDate = attributes["release_date"] as! String
        let posterPath = attributes["poster_path"] as? String
        let rating = attributes["vote_average"] as? NSNumber
        let overview = attributes["overview"] as! String
        
        self.init(id: id,
                  title: title,
                  releaseDate: releaseDate.dateValue,
                  posterPath: posterPath,
                  rating: rating,
                  overview: overview)
    }
    
}
