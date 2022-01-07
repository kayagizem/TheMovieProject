//
//  DiscoverViewController.swift
//  TheMovieProject
//
//  Created by gizem.kaya on 8.12.2021.
//

import UIKit
import Alamofire


class DiscoverViewController: UIViewController {
    
    @IBOutlet weak var MostPopulerMovies: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        APIClient.loadPopularMovies(api_key: "dc190303aea87bdf6e4faa3d59de8c59", language:"en-US", page:1, region:"US") { result in
            switch result{
            case .success(let movie):
                print("\n popular \n")
                print(movie)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        APIClient.loadUpcomingMovies(api_key: "dc190303aea87bdf6e4faa3d59de8c59", language:"en-US", page:1, region:"US") { result in
            switch result{
            case .success(let movie):
                print("\n upcomingMovies \n")
                print(movie)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        APIClient.loadNow_PlayingMovies(api_key: "dc190303aea87bdf6e4faa3d59de8c59", language:"en-US", page:1, region:"US") { result in
            switch result{
            case .success(let movie):
                print("\n now_playing \n")
                print(movie)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        APIClient.loadMovieDetail(movie_id:550, api_key: "dc190303aea87bdf6e4faa3d59de8c59", language:"en-US", append_to_response:"credits" ) { result in
            switch result{
            case .success(let movie):
                print("\n detail \n")
                print(movie)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        APIClient.loadMovieReview(movie_id:550, api_key: "dc190303aea87bdf6e4faa3d59de8c59", language:"en-US", page:1 ) { result in
            switch result{
            case .success(let movie):
                print("\n review \n")
                print(movie)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        APIClient.loadSimilarMovies(movie_id:550, api_key: "dc190303aea87bdf6e4faa3d59de8c59", language:"en-US", page:1 ) { result in
            switch result{
            case .success(let movie):
                print("\n similar \n")
                print(movie)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
            // Do any additional setup after loading the view.
        }
        
        
        /*
         // MARK: - Navigation
         
         // In a storyboard-based application, you will often want to do a little preparation before navigation
         override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
         }
         */
        
        private func loadMovies() {
            // TO-DO: Implement this
        }
        
        
    }
