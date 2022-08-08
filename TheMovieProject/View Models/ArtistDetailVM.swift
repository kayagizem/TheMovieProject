//
//  ArtistDetailVM.swift
//  TheMovieProject
//
//  Created by gizem.kaya on 8.08.2022.
//

import Foundation
import UIKit
import Alamofire
import AlamofireImage
import SDWebImage
import Cosmos

final class ArtistDetailViewModel {

    var delegate: ArtistDetailDelegate?

    func loadArtistDetail(artistId: Int) {
        APIClient.loadArtistDetail(artistId: artistId, appendToResponse: "credits") { [weak self] result in
            switch result {
            case .success(let artist):
                self?.delegate?.onArtistDetailLoaded(artist: artist)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
