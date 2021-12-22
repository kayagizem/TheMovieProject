//
//  Movie.swift
//  TheMovieProject
//
//  Created by gizem.kaya on 13.12.2021.
//

import Foundation


struct Movie: Codable {
    let page: Int
    let total_results: Int
    let total_pages: Int
    let results: [Result]
}
