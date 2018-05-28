//
//  Movie+Mapping.swift
//  Movies
//
//  Created by Olha Salii on 5/28/18.
//  Copyright © 2018 Olha Salii. All rights reserved.
//

import Foundation

extension Movie {
    
    convenience init(coreDataModel: CoreDataMovie) {
        let id = Int(coreDataModel.id)
        let title = coreDataModel.title ?? ""
        let releaseDate = coreDataModel.releaseDate ?? nil
        let posterPath = coreDataModel.posterPath ?? ""
        let rating = coreDataModel.rating
        let overview = coreDataModel.overview ?? ""
        
        self.init(id: id,
                  title: title,
                  releaseDate: releaseDate,
                  posterPath: posterPath,
                  rating: rating,
                  overview: overview)

        fillAdditionalInfo(from: coreDataModel)
    }

    private func fillAdditionalInfo(from coreDataModel: CoreDataMovie) {
        budget = Int(coreDataModel.budget)
        genres = coreDataModel.genres
        originalLanguage = coreDataModel.originalLanguage
        isLiked = coreDataModel.isLiked
    }

    //func getImageFromDisk(path: String) -> UIImage

}
