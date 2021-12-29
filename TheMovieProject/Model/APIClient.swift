//
//  APIClient.swift
//  TheMovieProject
//
//  Created by gizem.kaya on 18.12.2021.
//

import Foundation
import Alamofire

class APIClient {
    static func loadMovies(api_key: String, language: String, page: Int, region: String, completion:@escaping (Result<Movie,AFError>)->Void) {
        let jsonDecoder = JSONDecoder()
       // jsonDecoder.dateDecodingStrategy = .formatted(.articleDateFormatter)
        AF.request(APIRouter.loadMovies(api_key: api_key, language: language, page: page, region: region))
            .responseDecodable (decoder: jsonDecoder) { (response: DataResponse<Movie,AFError>) in
                    completion(response.result)
            }
            }
    }
 

