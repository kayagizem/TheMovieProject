//
//  DiscoverViewController.swift
//  TheMovieProject
//
//  Created by gizem.kaya on 8.12.2021.
//

import UIKit
import Alamofire
import AlamofireImage
import SDWebImage

class DiscoverViewController: UIViewController, UICollectionViewDelegate {
    var contentOffset: CGFloat = 0

    private let viewModel: DiscoverViewModel = DiscoverViewModel()

    @IBAction func upcomingTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "MoviesAllView", bundle: nil)
        guard let moviesListViewController = storyboard
                .instantiateViewController(withIdentifier: "SeeMoviesViewController") as? SeeMoviesViewController else {
            fatalError("Incorrect storyboard or view controller identifier.")
        }
        moviesListViewController.type = .upcoming
        navigationController?.pushViewController(moviesListViewController, animated: true)
    }

    @IBAction func mostPopularTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "MoviesAllView", bundle: nil)
        guard let moviesListViewController = storyboard
                .instantiateViewController(withIdentifier: "SeeMoviesViewController") as? SeeMoviesViewController else {
            fatalError("Incorrect storyboard or view controller identifier.")
        }
        moviesListViewController.type = .popular
        navigationController?.pushViewController(moviesListViewController, animated: true)
    }

    @IBAction func nowPlayingTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "MoviesAllView", bundle: nil)
        guard let moviesListViewController = storyboard
                .instantiateViewController(withIdentifier: "SeeMoviesViewController") as? SeeMoviesViewController else {
            fatalError("Incorrect storyboard or view controller identifier.")
        }
        moviesListViewController.type = .nowPlaying
        navigationController?.pushViewController(moviesListViewController, animated: true)
    }

    @IBOutlet weak var nowPlayingMoviesCollection: UICollectionView!
    @IBOutlet weak var upcomingMoviesCollection: UICollectionView!
    @IBOutlet weak var popularMoviesCollection: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Discover Movies"
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationItem.hidesBackButton = true
        self.viewModel.delegate = self
        registerNibCell()
        viewModel.loadMovies(type: .upcoming)
        viewModel.loadMovies(type: .popular)
        viewModel.loadMovies(type: .nowPlaying)
    }

    func registerNibCell() {
        let  discoverCellNib: UINib =  UINib(nibName: "DiscoverCell", bundle: nil)
        upcomingMoviesCollection.register(discoverCellNib, forCellWithReuseIdentifier: "DiscoverCell")
        let  nowPlayingCellNib: UINib =  UINib(nibName: "DiscoverCell", bundle: nil)
        nowPlayingMoviesCollection.register(nowPlayingCellNib, forCellWithReuseIdentifier: "DiscoverCell")
        let  popularMoviesCellNib: UINib =  UINib(nibName: "DiscoverCell", bundle: nil)
        popularMoviesCollection.register(popularMoviesCellNib, forCellWithReuseIdentifier: "DiscoverCell")
    }
}

extension DiscoverViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard: UIStoryboard? = UIStoryboard(name: "MovieDetailView", bundle: nil)
       guard let movieDetailsViewController: MovieDetailsViewController =
        storyboard?.instantiateViewController(withIdentifier: "MovieDetailsViewController")
                as? MovieDetailsViewController else {
                    fatalError("storyboard could not be initiated")
                }
        navigationController?.pushViewController(movieDetailsViewController, animated: true)
        if collectionView == upcomingMoviesCollection {
            movieDetailsViewController.selectedMovieId = viewModel.getUpcomingMovieForIndex(index: indexPath.row).id

        } else if collectionView == popularMoviesCollection {
            movieDetailsViewController.selectedMovieId = viewModel.getPopularMovieForIndex(index: indexPath.row).id

        } else {
            movieDetailsViewController.selectedMovieId = viewModel.getNowPlayingMovieForIndex(index: indexPath.row).id
        }
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.popularMoviesCollection {
            return viewModel.getNumberOfPopularMovies()
        } else if collectionView == self.upcomingMoviesCollection {
            return viewModel.getNumberOfUpcomingMovies() } else { return viewModel.getNumberOfNowPlayingMovies() }
    }

    // TODO: to shorten the function, separate into 3 by movies collection type

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath)
    -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DiscoverCell",
                                                            for: indexPath) as? DiscoverCollectionViewCell else {
            fatalError("Invalid cell identifier.")
        }

        if collectionView == self.popularMoviesCollection {
            cell.configure(info: viewModel.getInfoPopularMovie(for: indexPath))
        } else if collectionView == self.upcomingMoviesCollection {
            cell.configure(info: viewModel.getInfoUpcomingMovie(for: indexPath))
        } else {
            cell.configure(info: viewModel.getInfoNowPlayingMovie(for: indexPath))
        }
        return cell
    }
}

extension DiscoverViewController: RequestDelegate {
    func didUpdate(with state: ViewState) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            switch state {
            case .idle:
                break
            case .loading:
                break
            case .success:
                self.popularMoviesCollection.reloadData()
                self.upcomingMoviesCollection.reloadData()
                self.nowPlayingMoviesCollection.reloadData()
            case .error(let error):
                break
            }
        }
    }
}
