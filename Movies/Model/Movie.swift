//
//  Movie.swift
//  Movies
//
//  Created by Olha Salii on 5/17/18.
//  Copyright © 2018 Olha Salii. All rights reserved.
//

import Foundation
import SwiftyJSON

public class Movie: Hashable {
    public var hashValue: Int {
        return ObjectIdentifier(self).hashValue
    }
    
    public static func == (lhs: Movie, rhs: Movie) -> Bool {
        return ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
    }
  
    var id: Int
    var title: String
    var releaseDate: Date
    var posterPath: String
    var rating: Float
    var overview: String
    
    var budget: Int?
    var genres: [String]?
    var originalLanguage: String?

    init(id: Int, title: String, releaseDate: Date, posterPath: String, rating: Float, overview: String) {
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
        let posterPath = attributes["poster_path"] as! String
        let rating = attributes["vote_average"] as! NSNumber
        let overview = attributes["overview"] as! String
        
        self.init(id: id,
                  title: title,
                  releaseDate: releaseDate.dateValue,
                  posterPath: posterPath,
                  rating: rating.floatValue,
                  overview: overview)
    }
    
    convenience init(_ json: JSON) {
        let id = json["id"].intValue
        let title = json["title"].stringValue
        let releaseDate = json["release_date"].stringValue
        let posterPath = json["poster_path"].stringValue
        let rating = json["vote_average"].floatValue
        let overview = json["overview"].stringValue
        
        self.init(id: id,
                  title: title,
                  releaseDate: releaseDate.dateValue,
                  posterPath: posterPath,
                  rating: rating,
                  overview: overview)
    }
    
}
