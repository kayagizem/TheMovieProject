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

    @IBAction func UpcomingTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "UpcomingAll", sender: self)
    }
    
    @IBAction func MostPopularTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "MostPopularAll", sender: self)
    }
    
    @IBAction func NowPlayingTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "NowPlayingAll", sender: self)
    }
 
    @IBOutlet weak var NowPlayingMovies: UICollectionView!
    @IBOutlet weak var UpcomingMovies: UICollectionView!
    @IBOutlet weak var PopularMovies: UICollectionView!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource.delegate = self
        dataSource.loadPopularMovies(page:1)
        dataSource.loadUpcomingMovies(page:1)
        dataSource.loadNow_PlayingMovies(page:1)
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
            seeMoviesViewController.type = "MostPopular"
            }
        if segue.identifier == "NowPlayingAll",
            let seeMoviesViewController  = segue.destination as? SeeMoviesViewController {
            seeMoviesViewController.type = "NowPlaying"
            }
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
            var urlImage = ""
            do {
               urlImage = try APIRouter.loadImage(movie_poster_url: "\(movie.poster_path ?? "")").asURLRequest().url?.absoluteString ?? ""
            }catch{
                error
            }
            cell.MoviePoster.sd_setImage(with: URL(string:urlImage ), placeholderImage: UIImage(named: "placeholder.png"))
            return cell
            
        } else if collectionView == self.UpcomingMovies{
            let cellUpcoming = collectionView.dequeueReusableCell(withReuseIdentifier: "UpcomingCell", for: indexPath) as! UpcomingCollectionViewCell
            let movie = dataSource.getUpcomingMovieForIndex(index: indexPath.row)
            cellUpcoming.MovieLabel.text = movie.original_title
            cellUpcoming.MovieDuration.text = "Duration"
            var urlImage = ""
            do {
               urlImage = try APIRouter.loadImage(movie_poster_url: "\(movie.poster_path ?? "")").asURLRequest().url?.absoluteString ?? ""
            }catch{
                error
            }
            cellUpcoming.MoviePoster.sd_setImage(with: URL(string:urlImage ), placeholderImage: UIImage(named: "placeholder.png"))
            return cellUpcoming
            
        }else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NowPlayingCell", for: indexPath) as! NowPlayingCollectionViewCell
            let movie = dataSource.getNowPlayingMovieForIndex(index: indexPath.row)
            cell.MovieLabel.text = movie.original_title
            cell.MovieDuration.text = "Duration"
            var urlImage = ""
            do {
               urlImage = try APIRouter.loadImage(movie_poster_url: "\(movie.poster_path ?? "")").asURLRequest().url?.absoluteString ?? ""
            }catch{
                error
            }
            cell.MoviePoster.sd_setImage(with: URL(string:urlImage ), placeholderImage: UIImage(named: "placeholder.png"))
            return cell
            
        }
    }
    
}





