
//
//  SeeMoviesViewController.swift
//  TheMovieProject
//
//  Created by gizem.kaya on 6.02.2022.
//

import UIKit
import Alamofire
import AlamofireImage
import SDWebImage
import Cosmos

class SeeMoviesViewController: UIViewController, UIScrollViewDelegate, UICollectionViewDelegate {
    var isLoadingMore : Bool = false
    var page: Int = 1
    var delegate: DataSourceDelegate?
    let dataSource = DataSource()
    var type: String = ""
    var movies: [Movie] = []
    
    let ratingCosmos = CosmosView()
    
    
    
    
    @IBOutlet weak var MoviesCollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        page = 1
        dataSource.delegate = self
        MoviesCollection.dataSource = self
        MoviesCollection.delegate = self
        self.title = "\(type) Movies"
        
        if  type == "Most Popular" {
            dataSource.loadPopularMovies(page: page)
        } else if  type == "Upcoming" {
            dataSource.loadUpcomingMovies(page: page)
        } else {
            dataSource.loadNow_PlayingMovies(page: page)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! SeeAllMoviesCollectionViewCell
        if let indexPath = MoviesCollection.indexPath(for: cell){
            
            if  type == "Most Popular" {
                let movie = dataSource.getPopularMovieForIndex(index: indexPath.row)
                let movieDetailsViewController = segue.destination as! MovieDetailsViewController
                movieDetailsViewController.selectedMovie = movie        }
            
            else if  type == "Upcoming" {
                let movie = dataSource.getUpcomingMovieForIndex(index: indexPath.row)
                let movieDetailsViewController = segue.destination as! MovieDetailsViewController
                movieDetailsViewController.selectedMovie = movie        }
            else {
                let movie = dataSource.getNowPlayingMovieForIndex(index: indexPath.row)
                let movieDetailsViewController = segue.destination as! MovieDetailsViewController
                movieDetailsViewController.selectedMovie = movie
                
            }
        }
    }
}







extension SeeMoviesViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if type == "Most Popular"{
            return dataSource.getNumberOfPopularMovies()
        }else if type == "Upcoming"{
            return dataSource.getNumberOfUpcomingMovies()
        }else {
            return dataSource.getNumberOfNowPlayingMovies()
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SeeAll", for: indexPath) as! SeeAllMoviesCollectionViewCell
        var movie: Movie?
        
        if  type == "Most Popular"{
            movie = dataSource.getPopularMovieForIndex(index: indexPath.row)
        } else if type == "Upcoming"{
            movie = dataSource.getUpcomingMovieForIndex(index: indexPath.row)
        }else {
            movie = dataSource.getNowPlayingMovieForIndex(index: indexPath.row)
        }
        let margins = UIEdgeInsets(top: 3, left: 8, bottom: 3, right: 8)
        cell.frame = cell.frame.inset(by: margins)
        
        cell.MovieLabel.text = movie?.original_title
        var urlImage = ""
        do {
            urlImage = try APIRouter.loadImage(movie_poster_url: "\(movie?.poster_path ?? "")").asURLRequest().url?.absoluteString ?? ""
        }catch{
            debugPrint(error)
        }
        cell.MoviePoster.sd_setImage(with: URL(string:urlImage ), placeholderImage: UIImage(named: "placeholder.png"))
        cell.ratingView.rating = RatingUtilites.map(minRange: 0, maxRange: 10, minDomain: 0, maxDomain: 5, value: movie?.vote_average ?? 60.0)
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (self.MoviesCollection.contentOffset.y >= (self.MoviesCollection.contentSize.height - self.MoviesCollection.bounds.size.height)) {
            print("scroll edildi")
            if !isLoadingMore {
                isLoadingMore = true
                page = page + 1
                print(page)
                if  type == "Most Popular"{
                    dataSource.loadPopularMovies(page: page)
                } else if type == "Upcoming"{
                    dataSource.loadUpcomingMovies(page: page)
                } else {
                    dataSource.loadNow_PlayingMovies(page: page)
                }
                
                self.MoviesCollection.reloadData()
                self.isLoadingMore = false
                
            }
            
        }
    }
    
}

extension SeeMoviesViewController: DataSourceDelegate {
    func MostPopularLoaded() {
        if type == "Most Popular"{
            MoviesCollection.reloadData()
        }
    }
    
    func UpcomingLoaded() {
        if type == "Upcoming"{
            MoviesCollection.reloadData()
        }
    }
    
    func NowPlayingLoaded() {
        if type == "NowPlaying"{
            MoviesCollection.reloadData()
        }
    }
    
    
    
}
