//
//  Constants.swift
//  TheMovieProject
//
//  Created by gizem.kaya on 12.12.2021.
//

import Foundation


struct K {
    struct ProductionServer {
        static let baseURL = "api.themoviedb.org/3"
    }
    
    struct APIParameterKey {
        static let api_key = "dc190303aea87bdf6e4faa3d59de8c59"
        static let language = "language"
        static let page = "page"
        static let region = "region"

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
