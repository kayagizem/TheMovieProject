//
//  DataSource.swift
//  TheMovieProject
//
//  Created by gizem.kaya on 12.01.2022.
//

import Foundation
import UIKit
import Alamofire

class DataSource {
    
    var popularMoviesList: [Movie] = []
    var delegate: DataSourceDelegate?
    
    func loadPopularMovies(){
        APIClient.loadPopularMovies(api_key: "dc190303aea87bdf6e4faa3d59de8c59", language:"en-US", page:1, region:"US") { result in
            switch result{
            case .success(let movie):
                print("\n popular \n")
                print(movie.results!)
                self.popularMoviesList.append(contentsOf: movie.results!)
                
            case .failure(let error):
                print(error.localizedDescription)
            }
            DispatchQueue.main.async {
                self.delegate?.MostPopularLoaded()
            }
        }
    }
    
    func loadUpcomingMovies(){
        APIClient.loadUpcomingMovies(api_key: "dc190303aea87bdf6e4faa3d59de8c59", language:"en-US", page:1, region:"US") { result in
            switch result{
            case .success(let movie):
                print("\n upcomingMovies \n")
                print(movie)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func loadNow_PlayingMovies(){
        
        TheMovieProject.APIClient.loadNow_PlayingMovies(api_key: "dc190303aea87bdf6e4faa3d59de8c59", language:"en-US", page:1, region:"US") { result in
            switch result{
            case .success(let movie):
                print("\n now_playing \n")
                print(movie)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func loadMovieDetail(){
        TheMovieProject.APIClient.loadMovieDetail(movie_id:550, api_key: "dc190303aea87bdf6e4faa3d59de8c59", language:"en-US", append_to_response:"credits" ) { result in
            switch result{
            case .success(let movie):
                print("\n detail \n")
                print(movie)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func loadMovieReview(){
        
        TheMovieProject.APIClient.loadMovieReview(movie_id:550, api_key: "dc190303aea87bdf6e4faa3d59de8c59", language:"en-US", page:1 ) { result in
            switch result{
            case .success(let movie):
                print("\n review \n")
                print(movie)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    func loadSimilarMovies(){
        
        TheMovieProject.APIClient.loadSimilarMovies(movie_id:550, api_key: "dc190303aea87bdf6e4faa3d59de8c59", language:"en-US", page:1 ) { result in
            switch result{
            case .success(let movie):
                print("\n similar \n")
                print(movie)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    func getPopularMovieForIndex(index: Int) -> Movie{
        let realIndex = index % popularMoviesList.count
        return popularMoviesList[realIndex]
    }
    
    func getNumberOfPopularMovies() -> Int{
        return popularMoviesList.count
    }
}
