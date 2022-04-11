//
//  Constants.swift
//  TheMovieProject
//
//  Created by gizem.kaya on 12.12.2021.
//

import Foundation

struct Constants {
    struct ProductionServer {
        static let baseURL = "https://api.themoviedb.org/3"
        static let imageURL = "https://image.tmdb.org/t/p/original/"
        static let apiKey = "dc190303aea87bdf6e4faa3d59de8c59"
        static let defaultLang = "en-US"
    }

    struct APIParameterKey {
        static let apiKey = "apiKey"
        static let language = "language"
        static let page = "page"
        static let region = "region"
        static let appendToResponse = "appendToResponse"

    }
}

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
}

enum ContentType: String {
    case json = "application/json"
}
