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
    var upcomingMoviesList: [Movie] = []
    var popularMoviesList: [Movie] = []
    var nowPlayingMoviesList: [Movie] = []
    var delegate: DataSourceDelegate?
    
    func appendMovies(movie: Movie) {
    }
    
    func loadPopularMovies(page: Int) {
        APIClient.loadPopularMovies(api_key: Constants.ProductionServer.api_key, language: Constants.ProductionServer.default_lang, page: page, region: "US") { result in
            switch result {
            case .success(let movie):
                self.popularMoviesList.append(contentsOf: movie.results!)
            case .failure(let error):
                print(error.localizedDescription)
            }
            DispatchQueue.main.async {
                self.delegate?.mostPopularLoaded()
            }
        }
    }
    
    func loadUpcomingMovies(page: Int) {
        APIClient.loadUpcomingMovies(api_key: Constants.ProductionServer.api_key, language: Constants.ProductionServer.default_lang, page: page, region: "US") { result in
            switch result {
            case .success(let movie):
                self.upcomingMoviesList.append(contentsOf: movie.results!)
            case .failure(let error):
                print(error.localizedDescription)
            }
            DispatchQueue.main.async {
                self.delegate?.upcomingLoaded()
            }
        }
    }
    
    func loadNow_PlayingMovies(page: Int) {
        TheMovieProject.APIClient.loadNow_PlayingMovies(api_key: Constants.ProductionServer.api_key, language: Constants.ProductionServer.default_lang, page: page, region: "US") { result in
            switch result {
            case .success(let movie):
                self.nowPlayingMoviesList.append(contentsOf: movie.results!)
            case .failure(let error):
                print(error.localizedDescription)
            }
            DispatchQueue.main.async {
                self.delegate?.nowPlayingLoaded()
            }
        }
    }
    
    func loadMovieDetail() {
        TheMovieProject.APIClient.loadMovieDetail(movie_id: 550,
                                                  api_key: Constants.ProductionServer.api_key,
                                                  language: Constants.ProductionServer.default_lang, append_to_response: "credits" )
        { result in
            switch result {
            case .success(let movie):
                print("\n detail \n")
                print(movie)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func loadMovieReview() {
        TheMovieProject.APIClient.loadMovieReview(movie_id: 550, api_key: Constants.ProductionServer.api_key, language: Constants.ProductionServer.default_lang, page: 1 ) { result in
            switch result {
            case .success(let movie):
                print("\n review \n")
                print(movie)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func loadSimilarMovies() {
        TheMovieProject.APIClient.loadSimilarMovies(movie_id: 550, api_key: Constants.ProductionServer.api_key, language: Constants.ProductionServer.default_lang, page: 1 ) { result in
            switch result {
            case .success(let movie):
                print("\n similar \n")
                print(movie)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getPopularMovieForIndex(index: Int) -> Movie {
        let realIndex = index % popularMoviesList.count
        return popularMoviesList[realIndex]
    }
    
    func getUpcomingMovieForIndex(index: Int) -> Movie {
        let realIndex = index % upcomingMoviesList.count
        return upcomingMoviesList[realIndex]
    }
    
    func getNowPlayingMovieForIndex(index: Int) -> Movie {
        let realIndex = index % nowPlayingMoviesList.count
        return nowPlayingMoviesList[realIndex]
    }
    
    func getNumberOfPopularMovies() -> Int {
        return popularMoviesList.count
    }
    
    func getNumberOfUpcomingMovies() -> Int {
        return upcomingMoviesList.count
    }
    
    func getNumberOfNowPlayingMovies() -> Int {
        return nowPlayingMoviesList.count
    }
}
