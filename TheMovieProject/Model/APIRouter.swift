//
//  APIRouter.swift
//  TheMovieProject
//
//  Created by gizem.kaya on 8.12.2021.
//

import Foundation
import Alamofire

enum APIRouter: URLRequestConvertible {
    
    case loadMovies(api_key: String, language: String, page: Int, region: String)
    
    
       // MARK: - HTTPMethod
   
    private var method: HTTPMethod {
           switch self {
          
           case .loadMovies(_, _, _, _):
               return .get
           
               
           }
       }
       
       // MARK: - Path
       private var path: String {
           switch self {
           case .loadMovies(let api_key, let language, let page, _):
               return "/movie/popular?api_key=\(api_key)&language=\(language)/&page=\(page)"
           }
       }
       
       // MARK: - Parameters
       private var parameters: Parameters? {
           switch self {
           case .loadMovies(api_key: _, language: _, page: _, region: _):
               return nil
           }
       }
       
       // MARK: - URLRequestConvertible
       func asURLRequest() throws -> URLRequest {
           let url = try K.ProductionServer.baseURL.asURL()
           
           var urlRequest = URLRequest(url: url.appendingPathComponent(path))
           
           // HTTP Method
           urlRequest.httpMethod = method.rawValue
           
           // Common Headers
           urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
           urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
    
           // Parameters
           if let parameters = parameters {
               do {
                   urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
               } catch {
                   throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
               }
           }
           
           return urlRequest
       }
    
    
}
