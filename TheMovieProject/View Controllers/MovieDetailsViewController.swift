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
import Cosmos
class MovieDetailsViewController: UIViewController {
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var movieLanguage: UILabel!
    @IBOutlet weak var movieGenre: UILabel!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieDescription: UILabel!
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var ratingNumber: UILabel!
    @IBOutlet weak var ratingView: CosmosView!
    var selectedMovie: Movie?
    var genreParser: GenreParser? = GenreParser()
    var delegate: GenreDelegate?
    override func viewWillAppear(_ animated: Bool) {
        genreParser?.delegate = self
        if let movie = selectedMovie {
            self.movieTitle.text = movie.originalTitle
            self.releaseDate.text = movie.releaseDate
            if let language = LanguageType(rawValue: movie.originalLanguage ?? "en") {
                self.movieLanguage.text = "Language: \(language.language)"
            }
            self.movieDescription.text = movie.overview
            var urlImage = ""
            do {
                urlImage = try APIRouter.loadImage(moviePosterUrl: "\(movie.posterPath ?? "" )")
                    .asURLRequest().url?.absoluteString ?? ""
            } catch {
                debugPrint(error)
            }
            self.moviePoster.sd_setImage(with: URL(string: urlImage ),
                                         placeholderImage: UIImage(named: "placeholder.png"))
            self.thumbnail.sd_setImage(with: URL(string: urlImage ),
                                       placeholderImage: UIImage(named: "placeholder.png"))
            self.ratingView.rating = RatingUtilites.map(minRange: 0, maxRange: 10,
                                                        minDomain: 0, maxDomain: 5, value: movie.voteAverage ?? 0.0)
            self.ratingNumber.text = "\(RatingUtilites.map(minRange: 0, maxRange: 10, minDomain: 0, maxDomain: 5, value: movie.voteAverage ?? 0.0)) / 10"
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
extension MovieDetailsViewController: GenreDelegate {
    func genreLoaded() {
        if let genreArray = selectedMovie?.genreIds {
        self.movieGenre.text = genreParser?.toString(genreArray)
        }
    }
}
