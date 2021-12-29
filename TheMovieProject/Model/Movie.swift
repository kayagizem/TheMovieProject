//
//  Movie.swift
//  TheMovieProject
//
//  Created by gizem.kaya on 13.12.2021.
//

import Foundation


struct Movie: Codable {
    var page: Int
    var total_results: Int
    var total_pages: Int
    var results: [Results]?
    
     enum CodingKeys: String,CodingKey {
        case page =  "page"
        case total_results = "total_results"
        case total_pages = "total_pages"
        case results = "results"
    }
}
