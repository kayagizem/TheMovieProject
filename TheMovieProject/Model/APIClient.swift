//
//  APIClient.swift
//  TheMovieProject
//
//  Created by gizem.kaya on 18.12.2021.
//

import Foundation
import Alamofire

class APIClient {
    static func loadMovies(api_key: String, language: String, page: Int, region: String, completion:@escaping (Result)->Void) {
        AF.request(APIRouter.loadMovies(api_key: String, language: String, page: Int, region: String))
                 .responseDecodable { (response: DataResponse<User>) in
            completion(response.result)
        }
    }
}
