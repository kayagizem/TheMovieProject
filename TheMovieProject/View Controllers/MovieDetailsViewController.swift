//
//  MovieDetailsViewController.swift
//  TheMovieProject
//
//  Created by gizem.kaya on 9.03.2022.
//
//

import UIKit
import Alamofire
import AlamofireImage
import SDWebImage

class MovieDetailsViewController: UIViewController {

    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var movieLanguage: UILabel!
    @IBOutlet weak var movieGenre: UILabel!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieDescription: UILabel!
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var thumbnail: UIImageView!
    
    var selectedMovie: Movie?
    
    override func viewWillAppear(_ animated: Bool) {
        if let movie = selectedMovie {
            self.movieTitle.text = movie.original_title
            self.releaseDate.text = movie.release_date
            self.movieLanguage.text = movie.original_language
            self.movieDescription.text = movie.overview
            var urlImage = ""
            do {
                urlImage = try APIRouter.loadImage(movie_poster_url: "\(movie.poster_path ?? "")").asURLRequest().url?.absoluteString ?? ""
            }catch{
                debugPrint(error)
            }
            self.moviePoster.sd_setImage(with: URL(string:urlImage ), placeholderImage: UIImage(named: "placeholder.png"))
            self.thumbnail.sd_setImage(with: URL(string:urlImage ), placeholderImage: UIImage(named: "placeholder.png"))

        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

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

}

extension UIView {
func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
    layer.masksToBounds = false
    layer.shadowColor = color.cgColor
    layer.shadowOpacity = opacity
    layer.shadowOffset = offSet
    layer.shadowRadius = radius

    layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
    layer.shouldRasterize = true
    layer.rasterizationScale = scale ? UIScreen.main.scale : 1
  }
}
