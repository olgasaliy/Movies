//
//  MovieDetailedCell.swift
//  Movies
//
//  Created by Olga Saliy on 5/24/18.
//  Copyright © 2018 Olha Salii. All rights reserved.
//

import UIKit

protocol MovieDetailCellDelegate: AnyObject {
    func didTapLike(_ sender: MovieDetailCell)
}

class MovieDetailCell: UITableViewCell {

    weak var delegate: MovieDetailCellDelegate?
    
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var isLiked = false {
        didSet {
            self.likeButton.setImage(isLiked ? #imageLiteral(resourceName: "liked") : #imageLiteral(resourceName: "not_liked"), for: .normal) 
        }
    }
    
    func configure(with image: UIImage, description: String?, title: String?, liked: Bool) {
        self.titleLabel.text = title
        self.descriptionLabel.text = description ?? "Unknown genre"
        self.posterImageView.image = image
        self.isLiked = liked
    }
    
    @IBAction func likeTap(_ sender: Any) {
        isLiked = !isLiked
        delegate?.didTapLike(self)
    }

    
}
