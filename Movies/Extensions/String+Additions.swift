//
//  String+Additions.swift
//  Movies
//
//  Created by Olha Salii on 5/17/18.
//  Copyright © 2018 Olha Salii. All rights reserved.
//

import Foundation

extension String {
    
    var dateValue: Date {
        get {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            guard let date = dateFormatter.date(from: self) else {
                fatalError("ERROR: Date conversion failed due to mismatched format.")
            }
            return date
        }
    }
    
}
