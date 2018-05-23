//
//  HelpData.swift
//  Movies
//
//  Created by Olha Salii on 5/23/18.
//  Copyright © 2018 Olha Salii. All rights reserved.
//

import Foundation

public class Languages {
    
    // Can't init is singleton
    private init() { }
    
    // MARK: Shared Instance
    static let shared = Languages()
    
    var dictionary = [String : String]()
    
}

