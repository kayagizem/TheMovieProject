//
//  APIRouter.swift
//  TheMovieProject
//
//  Created by gizem.kaya on 8.12.2021.
//

import Foundation
import Alamofire

enum APIRouter: URLRequestConvertible {
    case loadPopularMovies(api_key: String, language: String, page: Int, region: String)
    case loadUpcomingMovies(api_key: String, language: String, page: Int, region: String)
    case loadNowPlayingMovies(api_key: String, language: String, page: Int, region: String)
    case loadMovieDetail(movie_id: Int, api_key: String, language: String, append_to_response: String)
    case loadMovieReview(movie_id: Int, api_key: String, language: String, page: Int)
    case loadSimilarMovies(movie_id: Int, api_key: String, language: String, page: Int)
    case loadImage(movie_poster_url: String)
    case genreList(api_key: String)
    // MARK: - HTTPMethod

    private var method: HTTPMethod {
           switch self {
           case .loadPopularMovies(_, _, _, _):
               return .get
           case .loadUpcomingMovies(_, _, _, _):
               return .get
           case .loadNowPlayingMovies(_, _, _, _):
               return .get
           case .loadMovieDetail(_, _, _, _):
               return .get
           case .loadMovieReview(_, _, _, _):
               return .get
           case .loadSimilarMovies(_, _, _, _):
               return .get
           case .loadImage(_):
               return .get
           case .genreList(_):
               return .get
           }
       }
       // MARK: - Path
       private var path: String {
           switch self {
           case .loadPopularMovies(_, _, _, _):
               return "/movie/popular"
           case .loadUpcomingMovies( _, _, _, _):
               return "/movie/upcoming"
           case .loadNowPlayingMovies( _, _, _, _):
               return "/movie/now_playing"
           case .loadMovieDetail(let movie_id, _, _, _):
               return "/movie/\(movie_id)"
           case .loadMovieReview(let movie_id, _, _, _):
               return "/movie/\(movie_id)/reviews"
           case .loadSimilarMovies(let movie_id, _, _, _):
               return "/movie/\(movie_id)/similar"
           case .loadImage(let movie_poster_url):
               return "\(movie_poster_url)"
           case .genreList(_):
               return "/genre/movie/list"
           }
       }
       // MARK: - Parameters
       private var parameters: Parameters? {
               switch self {
               case .loadPopularMovies(let api_key, let language, let page, _):
                   return ["api_key": api_key,
                           "page": page,
                           "language": language]
               case .loadUpcomingMovies(let api_key, let language, let page, _):
                   return ["api_key": api_key,
                           "page": page,
                           "language": language]
               case .loadNowPlayingMovies(let api_key, let language, let page, _):
                   return ["api_key": api_key,
                           "page": page,
                           "language": language]
               case .loadMovieDetail(let movie_id, let api_key, let language, let append_to_response):
                   return ["movie_id": movie_id,
                           "api_key": api_key,
                           "language": language,
                           "append_to_response": append_to_response]
               case .loadMovieReview(_, let api_key, let language, let page):
                   return ["api_key": api_key,
                           "language": language,
                           "page": page]
               case .loadSimilarMovies(_, let api_key, let language, let page):
                   return ["api_key": api_key,
                           "language": language,
                           "page": page]
               case .loadImage(movie_poster_url: _):
                   return [:]
               case .genreList(let api_key):
                   return ["api_key": api_key]
               }
       }
    private var baseURL: String {
            switch self {
            case .loadPopularMovies(api_key: _, language: _, page: _, region: _):
                return Constants.ProductionServer.baseURL
            case .loadUpcomingMovies(api_key: _, language: _, page: _, region: _):
                return Constants.ProductionServer.baseURL
            case .loadNowPlayingMovies(api_key: _, language: _, page: _, region: _):
                return Constants.ProductionServer.baseURL
            case .loadMovieDetail(movie_id: _, api_key: _, language: _, append_to_response: _):
                return Constants.ProductionServer.baseURL
            case .loadMovieReview(movie_id: _, api_key: _, language: _, page: _):
                return Constants.ProductionServer.baseURL
            case .loadSimilarMovies(movie_id: _, api_key: _, language: _, page: _):
                return Constants.ProductionServer.baseURL
            case .loadImage(movie_poster_url: _):
                return Constants.ProductionServer.imageURL
            case .genreList:
                return Constants.ProductionServer.baseURL
            }
    }
       // MARK: - URLRequestConvertible
       func asURLRequest() throws -> URLRequest {
           let url = try self.baseURL.asURL()
           var urlRequest = URLRequest(url: url.appendingPathComponent(path))
           // HTTP Method
           urlRequest.httpMethod = method.rawValue
           // Common Headers
           urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
           urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
           // Parameters
           if let parameters = parameters {
            if method == HTTPMethod.post {
                do {
                    urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
                    } catch {
                            throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
                              }
                          } else if method == HTTPMethod.get {
                              urlRequest = try URLEncoding.queryString.encode(urlRequest, with: parameters)
                          }
           }
           return urlRequest
       }

}
