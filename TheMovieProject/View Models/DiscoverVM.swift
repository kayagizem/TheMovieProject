//
//  Discover VM.swift
//  TheMovieProject
//
//  Created by gizem.kaya on 20.04.2022.
//

import Foundation

final class DiscoverViewModel {
    weak var delegate: RequestDelegate?
    private var state: ViewState {
        didSet {
            self.delegate?.didUpdate(with: state)
        }
    }

    var upcomingMoviesList: [Movie] = []
    var popularMoviesList: [Movie] = []
    var nowPlayingMoviesList: [Movie] = []

    init() {
        self.state = .idle
    }

    var numberOfUpcomingMovies: Int {
        upcomingMoviesList.count
    }
    var numberOfPopularMovies: Int {
        popularMoviesList.count
    }
    var numberOfNowPlayingMovies: Int {
        nowPlayingMoviesList.count
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

    //TODO: put tupples into a model

    func getInfoPopularMovie(for indexPath: IndexPath) -> MovieInfoModel {
        let movie = popularMoviesList[indexPath.row]
        return MovieInfoModel(name: movie.originalTitle, imageURL: movie.posterPath, rating: movie.voteAverage)
    }
    func getInfoUpcomingMovie(for indexPath: IndexPath) -> MovieInfoModel {
        let movie = upcomingMoviesList[indexPath.row]
        return MovieInfoModel(name: movie.originalTitle, imageURL: movie.posterPath, rating: movie.voteAverage)
    }
    func getInfoNowPlayingMovie(for indexPath: IndexPath) -> MovieInfoModel {
        let movie = nowPlayingMoviesList[indexPath.row]
        return MovieInfoModel(name: movie.originalTitle, imageURL: movie.posterPath, rating: movie.voteAverage)
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

    func loadMovies(type: MovieListType) {
        self.state = .loading
        switch type {
        case .upcoming:
            APIClient.loadUpcomingMovies(page: 1) { result in
                switch result {
                case .success(let movie):
                    self.upcomingMoviesList.append(contentsOf: movie.results!)
                    self.state = .success
                case .failure(let error):
                    print(error.localizedDescription)
                    self.state = .error(error)
                }
            }
        case .popular:
            APIClient.loadPopularMovies(page: 1) { [weak self] result in
                switch result {
                case .success(let movie):
                    self?.popularMoviesList.append(contentsOf: movie.results!)
                    self?.state = .success
                case .failure(let error):
                    print(error.localizedDescription)
                    self?.state = .error(error)
                }
            }
        case .nowPlaying:
            APIClient.loadNowPlayingMovies(page: 1) { result in
                switch result {
                case .success(let movie):
                    self.nowPlayingMoviesList.append(contentsOf: movie.results!)
                    self.state = .success
                case .failure(let error):
                    print(error.localizedDescription)
                    self.state = .error(error)
                }
            }
        }
    }

    /*
    func loadPopularMovies(page: Int) {
        self.state = .loading
        APIClient.loadPopularMovies(page: page) { [weak self] result in
            switch result {
            case .success(let movie):
                self?.popularMoviesList.append(contentsOf: movie.results!)
                self?.state = .success
            case .failure(let error):
                print(error.localizedDescription)
                self?.state = .error(error)
            }
        }
    }

    func loadUpcomingMovies(page: Int) {
        self.state = .loading
        APIClient.loadUpcomingMovies(page: page) { result in
            switch result {
            case .success(let movie):
                self.upcomingMoviesList.append(contentsOf: movie.results!)
                self.state = .success
            case .failure(let error):
                print(error.localizedDescription)
                self.state = .error(error)
            }
        }
    }

    func loadNowPlayingMovies(page: Int) {
        self.state = .loading
        APIClient.loadNowPlayingMovies(page: page) { result in
            switch result {
            case .success(let movie):
                self.nowPlayingMoviesList.append(contentsOf: movie.results!)
                self.state = .success
            case .failure(let error):
                print(error.localizedDescription)
                self.state = .error(error)
            }
        }
    }*/
}
