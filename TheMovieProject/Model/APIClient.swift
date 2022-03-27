//
//  APIClient.swift
//  TheMovieProject
//
//  Created by gizem.kaya on 18.12.2021.
//

import Foundation
import Alamofire

class APIClient {
    
   static func loadImage(movie_poster_url: String, completion:@escaping (Result<Results,AFError>)->Void) {
         let jsonDecoder = JSONDecoder()
        AF.request(APIRouter.loadImage(movie_poster_url: movie_poster_url))
             .responseDecodable (decoder: jsonDecoder) { (response: DataResponse<Results,AFError>) in
                     completion(response.result)
             }
         }
    
   static func loadPopularMovies(api_key: String, language: String, page: Int, region: String, completion:@escaping (Result<Results,AFError>)->Void) {
        let jsonDecoder = JSONDecoder()
        AF.request(APIRouter.loadPopularMovies(api_key: api_key, language: language, page: page, region: region))
            .responseDecodable (decoder: jsonDecoder) { (response: DataResponse<Results,AFError>) in
                    completion(response.result)
            }
        }
    
    static func loadUpcomingMovies(api_key: String, language: String, page: Int, region: String, completion:@escaping (Result<Results,AFError>)->Void) {
        let jsonDecoder = JSONDecoder()
        AF.request(APIRouter.loadUpcomingMovies(api_key: api_key, language: language, page: page, region: region))
            .responseDecodable (decoder: jsonDecoder) { (response: DataResponse<Results,AFError>) in
                    completion(response.result)
            }
        }
    
    static func loadNow_PlayingMovies(api_key: String, language: String, page: Int, region: String, completion:@escaping (Result<Results,AFError>)->Void) {
        let jsonDecoder = JSONDecoder()
        AF.request(APIRouter.loadNow_PlayingMovies(api_key: api_key, language: language, page: page, region: region))
            .responseDecodable (decoder: jsonDecoder) { (response: DataResponse<Results,AFError>) in
                    completion(response.result)
            }
        }
    
    static func loadMovieDetail(movie_id: Int, api_key: String, language: String, append_to_response: String, completion:@escaping (Result<Results,AFError>)->Void) {
        let jsonDecoder = JSONDecoder()
        AF.request(APIRouter.loadMovieDetail(movie_id: movie_id,api_key: api_key, language: language, append_to_response: append_to_response))
            .responseDecodable (decoder: jsonDecoder) { (response: DataResponse<Results,AFError>) in
                    completion(response.result)
            }
        }
    static func loadMovieReview(movie_id: Int, api_key: String, language: String, page: Int, completion:@escaping (Result<Results,AFError>)->Void) {
        let jsonDecoder = JSONDecoder()
        AF.request(APIRouter.loadMovieReview(movie_id: movie_id,api_key: api_key, language: language, page: page))
            .responseDecodable (decoder: jsonDecoder) { (response: DataResponse<Results,AFError>) in
                    completion(response.result)
            }
        }
    static func loadSimilarMovies(movie_id: Int, api_key: String, language: String, page: Int, completion:@escaping (Result<Results,AFError>)->Void) {
        let jsonDecoder = JSONDecoder()
        AF.request(APIRouter.loadMovieReview(movie_id: movie_id,api_key: api_key, language: language, page: page))
            .responseDecodable (decoder: jsonDecoder) { (response: DataResponse<Results,AFError>) in
                    completion(response.result)
            }
        }
    static func loadGenre(api_key: String,
    completion:@escaping (Result<GenreResponse,AFError>)->Void) {
        let jsonDecoder = JSONDecoder()
        AF.request(APIRouter.genreList(api_key: api_key))
            .responseDecodable (decoder: jsonDecoder) { (response: DataResponse<GenreResponse,AFError>) in
                completion(response.result)
                print("genreload")
                print(response)
            }
    }
    }
 

