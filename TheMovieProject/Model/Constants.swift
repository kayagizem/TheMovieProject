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
        
        static let api_key = "dc190303aea87bdf6e4faa3d59de8c59"
        static let default_lang = "en-US"
    }
    
    struct APIParameterKey {
        static let api_key = "api_key"
        static let language = "language"
        static let page = "page"
        static let region = "region"
        static let append_to_response = "append_to_response"

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
