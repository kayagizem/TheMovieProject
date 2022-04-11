//
//  APIClient.swift
//  TheMovieProject
//
//  Created by gizem.kaya on 18.12.2021.
//

import Foundation
import Alamofire

// TODO: Alamofire should only used in one network component 
class APIClient {
    static func loadImage(moviePosterUrl: String, completion:@escaping (Result<Results, AFError>) -> Void) {
        let jsonDecoder = JSONDecoder()
        AF.request(APIRouter.loadImage(moviePosterUrl: moviePosterUrl))
            .responseDecodable(decoder: jsonDecoder) { (response: DataResponse<Results, AFError>) in
                completion(response.result)

            }
    }

    static func loadPopularMovies(apiKey: String,
                                  language: String,
                                  page: Int,
                                  region: String,
                                  completion:@escaping (Result<Results, AFError>) -> Void) {
        let jsonDecoder = JSONDecoder()
        AF.request(APIRouter.loadPopularMovies(language: language, page: page, region: region))
            .responseDecodable(decoder: jsonDecoder) { (response: DataResponse<Results, AFError>) in
                completion(response.result)
                print(response)
            }
    }

    static func loadUpcomingMovies(apiKey: String,
                                   language: String,
                                   page: Int, region: String,
                                   completion:@escaping (Result<Results, AFError>) -> Void) {
        let jsonDecoder = JSONDecoder()
        AF.request(APIRouter.loadUpcomingMovies( language: language, page: page, region: region))
            .responseDecodable(decoder: jsonDecoder) { (response: DataResponse<Results, AFError>) in
                        completion(response.result)
                    }
            }

        static func loadNow_PlayingMovies(apiKey: String,
                                          language: String,
                                          page: Int,
                                          region: String,
                                          completion:@escaping (Result<Results, AFError>) -> Void) {
            let jsonDecoder = JSONDecoder()
            AF.request(APIRouter.loadNowPlayingMovies( language: language, page: page, region: region))
                .responseDecodable(decoder: jsonDecoder) { (response: DataResponse<Results, AFError>) in
                    completion(response.result)
                }
        }
        static func loadMovieDetail(movieId: Int,
                                    apiKey: String,
                                    language: String,
                                    appendToResponse: String,
                                    completion:@escaping (Result<Results, AFError>) -> Void) {
            let jsonDecoder = JSONDecoder()
            AF.request(APIRouter.loadMovieDetail(movieId: movieId,
                                                 language: language,
                                                 appendToResponse: appendToResponse))
                .responseDecodable(decoder: jsonDecoder) { (response: DataResponse<Results, AFError>) in
                    completion(response.result)
                }
        }
    static func loadMovieReview(movieId: Int,
                                apiKey: String,
                                language: String,
                                page: Int,
                                completion:@escaping (Result<Results, AFError>) -> Void) {
            let jsonDecoder = JSONDecoder()
            AF.request(APIRouter.loadMovieReview(movieId: movieId, language: language, page: page))
                .responseDecodable(decoder: jsonDecoder) { (response: DataResponse<Results, AFError>) in
                    completion(response.result)
                }
        }
    static func loadSimilarMovies(movieId: Int,
                                  apiKey: String,
                                  language: String,
                                  page: Int,
                                  completion:@escaping (Result<Results, AFError>) -> Void) {
            let jsonDecoder = JSONDecoder()
            AF.request(APIRouter.loadMovieReview(movieId: movieId, language: language, page: page))
                .responseDecodable(decoder: jsonDecoder) { (response: DataResponse<Results, AFError>) in
                    completion(response.result)
                }
        }
        static func loadGenre(apiKey: String, completion:@escaping (Result<GenreResponse, AFError>) -> Void) {
            let jsonDecoder = JSONDecoder()
            AF.request(APIRouter.genreList)
                .responseDecodable(decoder: jsonDecoder) { (response: DataResponse<GenreResponse, AFError>) in
                    completion(response.result)
            }
        }
    }
