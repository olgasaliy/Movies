//
//  MovieDetailedCell.swift
//  Movies
//
//  Created by Olga Saliy on 5/24/18.
//  Copyright © 2018 Olha Salii. All rights reserved.
//

import UIKit

class MovieDetailCell: UITableViewCell {

    @IBOutlet weak var likeImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    func configure(with image: UIImage, description: String, title: String, liked: Bool) {
        self.titleLabel.text = title
        self.descriptionLabel.text = description
        self.posterImageView.image = image
        self.likeImageView.image = liked ? #imageLiteral(resourceName: "liked") : #imageLiteral(resourceName: "not_liked")
    }

}
