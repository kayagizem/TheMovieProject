
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


class SeeMoviesViewController: UIViewController {
    var isLoadingMore : Bool = false
    var page: Int = 1
    var delegate: DataSourceDelegate?
    let dataSource = DataSource()
    var type: String = ""
    var movies: [Movie] = []
    
    @IBOutlet weak var MoviesCollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if  type == "MostPopular" {
            dataSource.loadPopularMovies(page: page)
        } else if  type == "Upcoming" {
            dataSource.loadUpcomingMovies(page: page)
        }else {
            dataSource.loadNow_PlayingMovies(page: page)
        }
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension SeeMoviesViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if type == "MostPopular"{
            return dataSource.getNumberOfPopularMovies()
        }else if type == "Upcoming"{
            return dataSource.getNumberOfUpcomingMovies()
        }else {
            return dataSource.getNumberOfNowPlayingMovies()
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if  type == "MostPopular"{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SeeAll", for: indexPath) as! SeeAllMoviesCollectionViewCell
            let movie = dataSource.getPopularMovieForIndex(index: indexPath.row)
            cell.MovieLabel.text = movie.original_title
            var urlImage = ""
            do {
                urlImage = try APIRouter.loadImage(movie_poster_url: "\(movie.poster_path ?? "")").asURLRequest().url?.absoluteString ?? ""
            }catch{
                error
            }
            cell.MoviePoster.sd_setImage(with: URL(string:urlImage ), placeholderImage: UIImage(named: "placeholder.png"))
            return cell
            
        } else if type == "Upcoming"{
            let cellUpcoming = collectionView.dequeueReusableCell(withReuseIdentifier: "SeeAll", for: indexPath) as! SeeAllMoviesCollectionViewCell
            let movie = dataSource.getUpcomingMovieForIndex(index: indexPath.row)
            cellUpcoming.MovieLabel.text = movie.original_title
            var urlImage = ""
            do {
                urlImage = try APIRouter.loadImage(movie_poster_url: "\(movie.poster_path ?? "")").asURLRequest().url?.absoluteString ?? ""
            }catch{
                error
            }
            cellUpcoming.MoviePoster.sd_setImage(with: URL(string:urlImage ), placeholderImage: UIImage(named: "placeholder.png"))
            return cellUpcoming
            
        }else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SeeAll", for: indexPath) as! SeeAllMoviesCollectionViewCell
            let movie = dataSource.getNowPlayingMovieForIndex(index: indexPath.row)
            cell.MovieLabel.text = movie.original_title
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
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (scrollView.contentOffset.y + 1) >= (scrollView.contentSize.height - scrollView.frame.size.height) {
            if !isLoadingMore {
                isLoadingMore = true
                page = page + 1
                self.movies.append(dataSource.loadPopularMovies(page: page))
                self.MoviesCollection.reloadData()
                self.isLoadingMore = false
                    
                }
                
            }
        }
    
}

extension SeeMoviesViewController: DataSourceDelegate{
    func MostPopularLoaded() {
        if type == "MostPopular"{
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
