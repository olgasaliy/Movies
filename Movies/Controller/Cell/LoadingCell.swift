//
//  LoadingCell.swift
//  Movies
//
//  Created by Olga Saliy on 5/24/18.
//  Copyright © 2018 Olha Salii. All rights reserved.
//

import UIKit

class LoadingCell: UITableViewCell {

    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        activityIndicator.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
