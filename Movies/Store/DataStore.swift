//
//  DataStore.swift
//  Movies
//
//  Created by Olha Salii on 5/22/18.
//  Copyright © 2018 Olha Salii. All rights reserved.
//

import Foundation

public class DataStore {
    
    // Can't init is singleton
    private init() {
        dataService = DataService(withBaseUrl: "https://api.themoviedb.org/3",
                                  apiKey: "f04e8ed93af390cef2ecddaf78379d66")
    }
    
    // MARK: Shared Instance
    static let shared = DataStore()
    
    let dataService: DataService
    
}
