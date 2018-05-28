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
    var releaseDate: Date?
    var posterPath: String
    var rating: Float
    var overview: String
    
    var budget: Int?
    var genres: String?
    var originalLanguage: String?
    
    var isLiked = false

    init() {
        self.id = 0
        self.title = "Undefined"
        self.releaseDate = nil
        self.posterPath = ""
        self.rating = 0
        self.overview = ""
    }
    
    init(id: Int, title: String, releaseDate: Date?, posterPath: String, rating: Float, overview: String) {
        self.id = id
        self.title = title
        self.releaseDate = releaseDate
        self.posterPath = posterPath
        self.rating = rating
        self.overview = overview
    }
    
    convenience init(_ json: JSON) {
        let id = json["id"].intValue
        let title = json["title"].stringValue
        let releaseDate = json["release_date"].stringValue
        let posterPath = json["poster_path"].stringValue
        let rating = json["vote_average"].floatValue
        let overview = json["overview"].stringValue
        
        let releaseDateValue = releaseDate != "" ? releaseDate.dateValue : nil
        
        self.init(id: id,
                  title: title,
                  releaseDate: releaseDateValue,
                  posterPath: posterPath,
                  rating: rating,
                  overview: overview)
    }
    
    func fillAdditionalInfo(_ json: JSON) {
        let budget = json["budget"].int
        var genres = ""
        json["genres"].arrayValue.forEach { subJson in
            genres += genres.count > 0 ? ", " : ""
             genres += "\(subJson["name"].stringValue)"
        }
        let originalLanguage = json["original_language"].stringValue
        
        self.budget = budget
        self.genres = genres
        self.originalLanguage = Languages.shared.dictionary[originalLanguage]
    }
    
}
