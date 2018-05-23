//
//  MovieCell.swift
//  Movies
//
//  Created by Olha Salii on 5/23/18.
//  Copyright © 2018 Olha Salii. All rights reserved.
//

import UIKit

class MovieCell: UICollectionViewCell {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    func configureCell(image: UIImage, title: String) {
        imageView.image = image
        label.text = title
    }
}
