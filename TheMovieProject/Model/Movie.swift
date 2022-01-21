//
//  Movie.swift
//  TheMovieProject
//
//  Created by gizem.kaya on 13.12.2021.
//

import Foundation

struct Movie: Codable {
    var vote_count: Int?
    var id: Int?
    var video: Bool?
    var title: String?
    var popularity: Double?
    var original_language: String?
    var original_title: String?
    var genre_ids: [Int]?
    var backdrop_path: String?
    var adult: Bool?
    var overview: String?
    var release_date: String?
    var vote_average: Double?
    var poster_path: String?
}
