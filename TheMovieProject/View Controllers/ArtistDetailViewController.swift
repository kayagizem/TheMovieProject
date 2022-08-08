//
//  ArtistDetailViewController.swift
//  TheMovieProject
//
//  Created by gizem.kaya on 5.08.2022.
//

import UIKit

class ArtistDetailViewController: UIViewController {

    @IBOutlet weak var artistImageGalleryCollection: UICollectionView!
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var albumPhoto5: UIImageView!
    @IBOutlet weak var albumPhoto4: UIImageView!
    @IBOutlet weak var albumPhoto3: UIImageView!
    @IBOutlet weak var albumPhoto2: UIImageView!
    @IBOutlet weak var albumPhoto1: UIImageView!
    @IBOutlet weak var photoNumber: UILabel!
    @IBOutlet weak var artistMainImage: UIImageView!
    
    private let viewModel: ArtistDetailViewModel = ArtistDetailViewModel()
    
    var selectedArtistId: Int?
    private var selectedArtist: Artist?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.delegate = self
        if let artistId = self.selectedArtistId {
            self.viewModel.loadArtistDetail(artistId: artistId)
        }
    }
    func configure(selectedArtist: Artist?){
        guard let artist = selectedArtist else {
            return
        }
        self.artistName.text = artist.name
        var urlImage = ""
        do {
            urlImage = try APIRouter.loadImage(moviePosterUrl: "\(artist.profilePath ?? "" )")
                .asURLRequest().url?.absoluteString ?? ""
        } catch {
            debugPrint(error)
        }
        self.artistMainImage.sd_setImage(with: URL(string: urlImage ),
                                     placeholderImage: UIImage(named: "placeholder.png"))
    }
    
    func registerNibCell() {
        let  artistCellNib: UINib =  UINib(nibName: "ArtistImageGalleryCell", bundle: nil)
        artistImageGalleryCollection.register(artistCellNib, forCellWithReuseIdentifier: "ArtistImageGalleryCell")
    }
}

extension ArtistDetailViewController: ArtistDetailDelegate {
    func onArtistDetailLoaded(artist: Artist) {
        self.selectedArtist = artist
        configure(selectedArtist: artist)
    }
}
