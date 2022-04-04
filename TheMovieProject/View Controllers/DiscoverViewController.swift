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
    // swiftlint:disable force_cast
    @IBAction func upcomingTapped(_ sender: Any) {
        let storyboard: UIStoryboard? = UIStoryboard(name: "MoviesAllView", bundle: nil)
        let moviesListViewController: SeeMoviesViewController =
        storyboard?.instantiateViewController(withIdentifier: "SeeMoviesViewController")
        as! SeeMoviesViewController
        moviesListViewController.type = "Upcoming"
        moviesListViewController.dataSource = dataSource
        navigationController?.pushViewController(moviesListViewController, animated: true)
    }
    @IBAction func mostPopularTapped(_ sender: Any) {
        let storyboard: UIStoryboard? = UIStoryboard(name: "MoviesAllView", bundle: nil)
        let moviesListViewController: SeeMoviesViewController =
        storyboard?.instantiateViewController(withIdentifier: "SeeMoviesViewController") as! SeeMoviesViewController
        moviesListViewController.type = "Most Popular"
        moviesListViewController.dataSource = dataSource
        navigationController?.pushViewController(moviesListViewController, animated: true)
    }
    @IBAction func nowPlayingTapped(_ sender: Any) {
        let storyboard: UIStoryboard? = UIStoryboard(name: "MoviesAllView", bundle: nil)
        let moviesListViewController: SeeMoviesViewController =
        storyboard?.instantiateViewController(withIdentifier: "SeeMoviesViewController") as! SeeMoviesViewController
        moviesListViewController.type = "NowPlaying"
        moviesListViewController.dataSource = dataSource
        navigationController?.pushViewController(moviesListViewController, animated: true)
            }
    // swiftlint:disable force_cast
    @IBOutlet weak var nowPlayingMoviesCollection: UICollectionView!
    @IBOutlet weak var upcomingMoviesCollection: UICollectionView!
    @IBOutlet weak var opularMoviesCollection: UICollectionView!
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
        upcomingMoviesCollection.register(discoverCellNib, forCellWithReuseIdentifier: "UpcomingCell")
        let  nowPlayingCellNib: UINib =  UINib(nibName: "NowPlayingCell", bundle: nil)
        nowPlayingMoviesCollection.register(nowPlayingCellNib, forCellWithReuseIdentifier: "NowPlayingCell")
        let  popularMoviesCellNib: UINib =  UINib(nibName: "PopularMoviesCell", bundle: nil)
        opularMoviesCollection.register(popularMoviesCellNib, forCellWithReuseIdentifier: "PopularMoviesCell")
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
        opularMoviesCollection.reloadData()
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

        } else if collectionView == opularMoviesCollection {
            movieDetailsViewController.selectedMovie = dataSource.getPopularMovieForIndex(index: indexPath.row)

        } else {
            movieDetailsViewController.selectedMovie = dataSource.getUpcomingMovieForIndex(index: indexPath.row)
        }
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.opularMoviesCollection {
            return dataSource.getNumberOfPopularMovies()
        } else if collectionView == self.upcomingMoviesCollection {
            return dataSource.getNumberOfUpcomingMovies() } else { return dataSource.getNumberOfNowPlayingMovies() }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath)
    -> UICollectionViewCell {
        if collectionView == self.opularMoviesCollection {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopularMoviesCell", for: indexPath)
            as! MostPopulerCollectionViewCell
            let movie = dataSource.getPopularMovieForIndex(index: indexPath.row)
            cell.movieLabel.text = movie.original_title
            cell.movieDuration.text = "Duration"
            var urlImage = ""
            do {
               urlImage = try APIRouter.loadImage(movie_poster_url: "\(movie.poster_path ?? "")")
                    .asURLRequest().url?.absoluteString ?? ""
            } catch { error }
            cell.moviePosterImageView.sd_setImage(with: URL(string: urlImage ),
            placeholderImage: UIImage(named: "placeholder.png"))
            return cell
        } else if collectionView == self.upcomingMoviesCollection {
            let cellUpcoming = collectionView
                .dequeueReusableCell(withReuseIdentifier: "UpcomingCell", for: indexPath) as! UpcomingCollectionViewCell
            let movie = dataSource.getUpcomingMovieForIndex(index: indexPath.row)
            cellUpcoming.movieLabel.text = movie.original_title
            cellUpcoming.movieDuration.text = "Duration"
            var urlImage = ""
            do {
               urlImage = try APIRouter.loadImage(movie_poster_url: "\(movie.poster_path ?? "")")
                    .asURLRequest().url?.absoluteString ?? ""
            } catch { error }
            cellUpcoming.moviePosterImageView
                .sd_setImage(with: URL(string: urlImage ), placeholderImage: UIImage(named: "placeholder.png"))
            return cellUpcoming } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NowPlayingCell", for: indexPath)
                as! NowPlayingCollectionViewCell
            let movie = dataSource.getNowPlayingMovieForIndex(index: indexPath.row)
            cell.movieLabel.text = movie.original_title
            cell.movieDuration.text = "Duration"
            var urlImage = ""
            do {
               urlImage = try APIRouter.loadImage(movie_poster_url: "\(movie.poster_path ?? "")")
                    .asURLRequest().url?.absoluteString ?? ""
            } catch { error }
            cell.moviePosterImageView.sd_setImage(with: URL(string: urlImage ),
                                                  placeholderImage: UIImage(named: "placeholder.png"))
            return cell
        }
    }
}
