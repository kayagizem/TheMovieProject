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

        APIClient.loadMovies(api_key: "dc190303aea87bdf6e4faa3d59de8c59", language:"en-US", page:1, region:"US") { result in
            switch result{
            case .success(let movie):
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
