//
//  DiscoverViewController.swift
//  TheMovieProject
//
//  Created by gizem.kaya on 8.12.2021.
//

import UIKit
import Alamofire


class DiscoverViewController: UIViewController, UICollectionViewDelegate {
    
    @IBOutlet weak var PopularMovies: UICollectionView!
    var dataSource = DataSource()
        override func viewDidLoad() {
        super.viewDidLoad()
            PopularMovies.delegate = self
            PopularMovies.dataSource = self
            dataSource.loadPopularMovies()
        }
    }


extension DiscoverViewController: DataSourceDelegate{
    func MostPopularLoaded() {
        PopularMovies.reloadData()
    }
}


extension DiscoverViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.getNumberOfPopularMovies()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopularMoviesCell", for: indexPath) as! MostPopulerCollectionViewCell
        let movie = dataSource.getPopularMovieForIndex(index: indexPath.row)
        cell.MovieLabel.text = movie.original_title
        let posterURL = movie.poster_path
        
        
        AF.request(String(describing: posterURL),method: .get).response{ response in
         switch response.result {
          case .success(let responseData):
             cell.MoviePoster.image = UIImage(data: responseData!, scale:1)
          case .failure(let error):
              print("error--->",error)
          }
      }
        return cell

}
}

   
