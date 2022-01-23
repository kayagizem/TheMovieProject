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
    
    @IBOutlet weak var NowPlayingMovies: UICollectionView!
    @IBOutlet weak var UpcomingMovies: UICollectionView!
    @IBOutlet weak var PopularMovies: UICollectionView!
    
    var dataSource = DataSource()
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource.delegate = self
        dataSource.loadPopularMovies()
        dataSource.loadUpcomingMovies()
        dataSource.loadNow_PlayingMovies()
        
        
    }
    
}


extension DiscoverViewController: DataSourceDelegate{
    func NowPlayingLoaded() {
        NowPlayingMovies.reloadData()
    }
    
    func UpcomingLoaded() {
        UpcomingMovies.reloadData()
    }
    
    func MostPopularLoaded() {
        PopularMovies.reloadData()
        
    }
}


extension DiscoverViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.PopularMovies{
            return dataSource.getNumberOfPopularMovies()
        }else if collectionView == self.UpcomingMovies{
            return dataSource.getNumberOfUpcomingMovies()
        }else {
            return dataSource.getNumberOfNowPlayingMovies()
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.PopularMovies{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopularMoviesCell", for: indexPath) as! MostPopulerCollectionViewCell
            let movie = dataSource.getPopularMovieForIndex(index: indexPath.row)
            cell.MovieLabel.text = movie.original_title
            cell.MovieDuration.text = "Duration"
            let baseURL = "https://image.tmdb.org/t/p/original/"
            let ImageURL = "\(baseURL)\(movie.poster_path ?? "")"
            cell.MoviePoster.sd_setImage(with: URL(string:ImageURL ), placeholderImage: UIImage(named: "placeholder.png"))
            return cell
        } else if collectionView == self.UpcomingMovies{
            let cellUpcoming = collectionView.dequeueReusableCell(withReuseIdentifier: "UpcomingCell", for: indexPath) as! UpcomingCollectionViewCell
            let movie = dataSource.getUpcomingMovieForIndex(index: indexPath.row)
            cellUpcoming.MovieLabel.text = movie.original_title
            cellUpcoming.MovieDuration.text = "Duration"
            let baseURL = "https://image.tmdb.org/t/p/original/"
            let ImageURL = "\(baseURL)\(movie.poster_path ?? "")"
            cellUpcoming.MoviePoster.sd_setImage(with: URL(string:ImageURL ), placeholderImage: UIImage(named: "placeholder.png"))
            return cellUpcoming
        }else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NowPlayingCell", for: indexPath) as! NowPlayingCollectionViewCell
            let movie = dataSource.getNowPlayingMovieForIndex(index: indexPath.row)
            cell.MovieLabel.text = movie.original_title
            cell.MovieDuration.text = "Duration"
            let baseURL = "https://image.tmdb.org/t/p/original/"
            let ImageURL = "\(baseURL)\(movie.poster_path ?? "")"
            cell.MoviePoster.sd_setImage(with: URL(string:ImageURL ), placeholderImage: UIImage(named: "placeholder.png"))
            return cell
            
        }
    }
    
}





