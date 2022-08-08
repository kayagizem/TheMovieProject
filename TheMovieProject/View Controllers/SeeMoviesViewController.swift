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
import Cosmos

class SeeMoviesViewController: UIViewController, UIScrollViewDelegate, UICollectionViewDelegate, UISearchBarDelegate {

    private var isLoadingMore: Bool = false
    private var page: Int = 1
    var type: MovieListType = .nowPlaying
    private let viewModel: SeeMoviesViewModel = SeeMoviesViewModel()
    private let ratingCosmos = CosmosView()
    private var searchActive: Bool = false
    @IBOutlet weak private var allMoviesCollection: UICollectionView!
    private var category: String = "Now Playing"


    override func viewDidLoad() {
        super.viewDidLoad()
        findCategory()
        self.navigationItem.title = "\(category) Movies "
        registerNibCell()
        loadMoviesForCategory()
        page = 1
        allMoviesCollection.dataSource = self
        allMoviesCollection.delegate = self
        self.viewModel.delegate = self
    }

    func registerNibCell() {
        let  moviesAllCellNib: UINib =  UINib(nibName: "MoviesAllCell", bundle: nil)
        allMoviesCollection.register(moviesAllCellNib, forCellWithReuseIdentifier: "SeeAll")
    }

    func findCategory() {
        switch type {
        case .nowPlaying:
            category = "Now Playing"
        case .upcoming:
            category = "Upcoming"
        case .popular:
            category = "Most Popular"
        }
    }

    func loadMoviesForCategory() {
        switch type {
        case .nowPlaying:
            viewModel.loadNowPlayingMovies(page: page)
        case .upcoming:
            viewModel.loadUpcomingMovies(page: page)
        case .popular:
            viewModel.loadPopularMovies(page: page)
        }
    }
}

extension SeeMoviesViewController: UICollectionViewDataSource {
   
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
            searchActive = true
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if searchActive {
            return viewModel.getNumberOfFilteredMovies()
        } else {
            switch type {
            case .nowPlaying:
                return viewModel.getNumberOfNowPlayingMovies()
            case .upcoming:
                return viewModel.getNumberOfUpcomingMovies()
            case .popular:
                return viewModel.getNumberOfPopularMovies()
            }
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath)
    -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SeeAll", for: indexPath)
                as? SeeAllMoviesCollectionViewCell else {
                    fatalError("cell could not initiated")
                }
        if searchActive {
            cell.configure(info: viewModel.getInfoFilteredMovie(for: indexPath))
        } else {
            switch type {
            case .nowPlaying:
                cell.configure(info: viewModel.getInfoNowPlayingMovie(for: indexPath))
            case .upcoming:
                cell.configure(info: viewModel.getInfoUpcomingMovie(for: indexPath))
            case .popular:
                cell.configure(info: viewModel.getInfoPopularMovie(for: indexPath))
            }
        }

        let margins = UIEdgeInsets(top: 3, left: 8, bottom: 3, right: 8)
        cell.frame = cell.frame.inset(by: margins)

        return cell
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if self.allMoviesCollection.contentOffset.y >=
            (self.allMoviesCollection.contentSize.height - self.allMoviesCollection.bounds.size.height) {
            if !isLoadingMore {
                isLoadingMore = true
                page += 1
                switch type {
                case .nowPlaying:
                    viewModel.loadNowPlayingMovies(page: page)
                case .upcoming:
                    viewModel.loadUpcomingMovies(page: page)
                case .popular:
                    viewModel.loadPopularMovies(page: page)
                }
                self.allMoviesCollection.reloadData()
                self.isLoadingMore = false
            }
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard: UIStoryboard? = UIStoryboard(name: "MovieDetailView", bundle: nil)
        guard let movieDetailsViewController: MovieDetailsViewController =
        storyboard?.instantiateViewController(withIdentifier: "MovieDetailsViewController")
                as? MovieDetailsViewController else {
                    fatalError()
                }

        switch type {
        case .nowPlaying:
            movieDetailsViewController.selectedMovieId = viewModel.getNowPlayingMovieForIndex(index: indexPath.row).id
        case .upcoming:
            movieDetailsViewController.selectedMovieId = viewModel.getUpcomingMovieForIndex(index: indexPath.row).id
        case .popular:
            movieDetailsViewController.selectedMovieId = viewModel.getPopularMovieForIndex(index: indexPath.row).id
        }
        navigationController?.pushViewController(movieDetailsViewController, animated: true)
    }

    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let headerView: UICollectionReusableView =  collectionView
                .dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                  withReuseIdentifier: "SearchBar", for: indexPath)
               return headerView
           }
           return UICollectionReusableView()
      }
    // swiftlint:disable force_cast
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        switch type {
        case .nowPlaying:
            viewModel.filteredMovies = viewModel.nowPlayingMoviesList.filter { (movie: Movie) -> Bool in
                return (movie.title?.lowercased().contains(searchText.lowercased()))!
              }
        case .upcoming:
            viewModel.filteredMovies = viewModel.upcomingMoviesList.filter { (movie: Movie) -> Bool in
                return (movie.title?.lowercased().contains(searchText.lowercased()))!
              }
        case .popular:
            viewModel.filteredMovies = viewModel.popularMoviesList.filter { (movie: Movie) -> Bool in
                return (movie.title?.lowercased().contains(searchText.lowercased()))!
              }
        }
        searchActive = !viewModel.filteredMovies.isEmpty
        self.allMoviesCollection.reloadData()
    }
}

extension SeeMoviesViewController: RequestDelegate {
    func didUpdate(with state: ViewState) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            switch state {
            case .idle:
                break
            case .loading:
                break
            case .success:
                self.allMoviesCollection.reloadData()
            case .error(let error):
                break
            }
        }
    }
}
