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
    var dataSource = DataSource()

    @IBAction func upcomingTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "MoviesAllView", bundle: nil)
        guard let moviesListViewController = storyboard.instantiateViewController(withIdentifier: "SeeMoviesViewController") as? SeeMoviesViewController else {
            fatalError("Incorrect storyboard or view controller identifier.")
        }
        moviesListViewController.type = "Upcoming"
        moviesListViewController.dataSource = dataSource
        navigationController?.pushViewController(moviesListViewController, animated: true)
    }

    @IBAction func mostPopularTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "MoviesAllView", bundle: nil)
        guard let moviesListViewController = storyboard.instantiateViewController(withIdentifier: "SeeMoviesViewController") as? SeeMoviesViewController else {
            fatalError("Incorrect storyboard or view controller identifier.")
        }
        moviesListViewController.type = "Most Popular"
        moviesListViewController.dataSource = dataSource
        navigationController?.pushViewController(moviesListViewController, animated: true)
    }

    @IBAction func nowPlayingTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "MoviesAllView", bundle: nil)
        guard let moviesListViewController = storyboard.instantiateViewController(withIdentifier: "SeeMoviesViewController") as? SeeMoviesViewController else {
            fatalError("Incorrect storyboard or view controller identifier.")
        }
        moviesListViewController.type = "NowPlaying"
        moviesListViewController.dataSource = dataSource
        navigationController?.pushViewController(moviesListViewController, animated: true)
    }

    @IBOutlet weak var nowPlayingMoviesCollection: UICollectionView!
    @IBOutlet weak var upcomingMoviesCollection: UICollectionView!
    @IBOutlet weak var popularMoviesCollection: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        registerNibCell()
        dataSource.delegate = self
        dataSource.loadPopularMovies(page: 1)
        dataSource.loadUpcomingMovies(page: 1)
        dataSource.loadNow_PlayingMovies(page: 1)
        self.title = "Discover Movies"
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.

        if segue.identifier == "UpcomingAll",
           let seeMoviesViewController  = segue.destination as? SeeMoviesViewController {
            seeMoviesViewController.type = "Upcoming"
        }

        if segue.identifier == "MostPopularAll",
           let seeMoviesViewController  = segue.destination as? SeeMoviesViewController {
            seeMoviesViewController.type = "Most Popular"
        }

        if segue.identifier == "NowPlayingAll",
           let seeMoviesViewController  = segue.destination as? SeeMoviesViewController {
            seeMoviesViewController.type = "NowPlaying"
        }

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

extension DiscoverViewController: DataSourceDelegate {
    func nowPlayingLoaded() {
        nowPlayingMoviesCollection.reloadData()
    }
    func upcomingLoaded() {
        upcomingMoviesCollection.reloadData()
    }
    func mostPopularLoaded() {
        popularMoviesCollection.reloadData()
    }
}

extension DiscoverViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard: UIStoryboard? = UIStoryboard(name: "MovieDetailView", bundle: nil)
        let movieDetailsViewController: MovieDetailsViewController =
        storyboard?.instantiateViewController(withIdentifier: "MovieDetailsViewController")
        as! MovieDetailsViewController
        navigationController?.pushViewController(movieDetailsViewController, animated: true)
        if collectionView == nowPlayingMoviesCollection {
            movieDetailsViewController.selectedMovie = dataSource.getNowPlayingMovieForIndex(index: indexPath.row)

        } else if collectionView == popularMoviesCollection {
            movieDetailsViewController.selectedMovie = dataSource.getPopularMovieForIndex(index: indexPath.row)

        } else {
            movieDetailsViewController.selectedMovie = dataSource.getUpcomingMovieForIndex(index: indexPath.row)
        }
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.popularMoviesCollection {
            return dataSource.getNumberOfPopularMovies()
        } else if collectionView == self.upcomingMoviesCollection {
            return dataSource.getNumberOfUpcomingMovies() } else { return dataSource.getNumberOfNowPlayingMovies() }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath)
    -> UICollectionViewCell {
        if collectionView == self.popularMoviesCollection {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DiscoverCell", for: indexPath) as? DiscoverCollectionViewCell else {
                fatalError("Invalid cell identifier.")
            }
            let movie = dataSource.getPopularMovieForIndex(index: indexPath.row)
            cell.movieLabel.text = movie.original_title
            cell.movieDuration.text = "Duration"
            var urlImage = ""
            do {
                urlImage = try APIRouter.loadImage(movie_poster_url: "\(movie.poster_path ?? "")")
                    .asURLRequest().url?.absoluteString ?? ""
            } catch { fatalError("image cannot be cathced")}
            cell.moviePosterImageView.sd_setImage(with: URL(string: urlImage ),
                                                  placeholderImage: UIImage(named: "placeholder.png"))
            return cell
        } else if collectionView == self.upcomingMoviesCollection {
            guard let cellUpcoming = collectionView.dequeueReusableCell(withReuseIdentifier: "DiscoverCell", for: indexPath) as? DiscoverCollectionViewCell else {
                fatalError("Invalid cell identifier.")
            }
            let movie = dataSource.getUpcomingMovieForIndex(index: indexPath.row)
            cellUpcoming.movieLabel.text = movie.original_title
            cellUpcoming.movieDuration.text = "Duration"
            var urlImage = ""
            do {
                urlImage = try APIRouter.loadImage(movie_poster_url: "\(movie.poster_path ?? "")")
                    .asURLRequest().url?.absoluteString ?? ""
            } catch { fatalError("image cannot be cathced")}
            cellUpcoming.moviePosterImageView
                .sd_setImage(with: URL(string: urlImage ), placeholderImage: UIImage(named: "placeholder.png"))
            return cellUpcoming } else {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DiscoverCell", for: indexPath) as? DiscoverCollectionViewCell else {
                    fatalError("Invalid cell identifier.")
                }
            let movie = dataSource.getNowPlayingMovieForIndex(index: indexPath.row)
            cell.movieLabel.text = movie.original_title
            cell.movieDuration.text = "Duration"
            var urlImage = ""
            do {
                urlImage = try APIRouter.loadImage(movie_poster_url: "\(movie.poster_path ?? "")")
                    .asURLRequest().url?.absoluteString ?? ""
            } catch { fatalError("image cannot be cathced")}
            cell.moviePosterImageView.sd_setImage(with: URL(string: urlImage ),
                                                  placeholderImage: UIImage(named: "placeholder.png"))
            return cell
        }
    }
}
