//
//  Result.swift
//  TheMovieProject
//
//  Created by gizem.kaya on 13.12.2021.
//

import Foundation


struct Results: Codable {
    let vote_count: Int?
    let id: Int?
    let video: Bool?
    let title: String?
    let popularity: Double?
    let original_language: String?
    let original_title: String?
    let genre_ids: [Int]?
    let backdrop_path: String?
    let adult: Bool?
    let overview: String?
    let release_date: String?
    let vote_average: Double?
    let poster_path: String?
}
