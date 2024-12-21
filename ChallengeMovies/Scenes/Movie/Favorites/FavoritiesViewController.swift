//
//  FavoritiesViewController.swift
//  ChallengeMovies
//
//  Created by Mario Alfonso Orozco Pacheco on 8/11/24.
//

import UIKit

class FavoritesViewController: UIViewController {
  
    private let favoritesView: FavoritesView
    private let errorView: ErrorView
    private let service: MoviesDetailWebService
    private let favoriteService: FavoriteMovieService
//    private let navigationStyle: NavigationBarStyle
//    private let localStorage: FavoritesLocalStorageProtocol
    
    init(favoritesView: FavoritesView, service: MoviesDetailWebService, favoriteService: FavoriteMovieService, errorView: ErrorView) {
        self.favoritesView = favoritesView
        self.service = service
//        self.navigationStyle = navigationStyle
        self.errorView = errorView
        self.favoriteService = favoriteService
//        self.localStorage = localStorage
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.navigationStyle.configure(self)
//        self.fetchMovies()
        self.fetchFavorites()
    }
    
    private func configureView() {
        self.view = self.favoritesView
        self.favoritesView.delegate = self
    }
    
    private func fetchFavorites(){
        
        var returnIds: [String] = []
        
        if let list = self.favoriteService.getAll(), !list.isEmpty {
            for movie in list {
//                print(movie)
                returnIds.append(String(movie.idMovie))
            }
        }
        
        self.service.fetchMultipleMoviesDetail(movieIds: returnIds) { detailDTO in
            self.favoritesView.reloadData(detailDTO.toDetail)
        }
    }
    
//    private func fetchMovies() {
        //        self.service.fetch { moviesDTO in
        //            self.favoritesView.reloadCollectionView(moviesDTO.toMovies, searchText: nil)
        //        }
//        let result = self.localStorage.fetch()
//        self.favoritesView.reloadData(result.toMovies)
        //        self.allMovies = movies
        //        self.filteredMovies = movies
        //        self.favoritesView.reloadCollectionView(movies, searchText: nil)
//    }
}
extension FavoritesViewController: FavoritesViewDelegate {
    func favoritesView(_ view: FavoritesView, didSelector movies: commonDetails) {
        
    }
}

//extension FavoritesViewController: SearchBarViewDelegate {
//    func didUpdateSearchResults(searchText: String) {
//        if searchText.isEmpty {
//            filteredMovies = allMovies
//        } else {
//            filteredMovies = allMovies.filter { movie in
//                movie.title.lowercased().contains(searchText.lowercased()) ||
//                String(movie.voteAverage).contains(searchText)
//            }
//        }
//        
//        self.favoritesView.reloadCollectionView(filteredMovies, searchText: searchText)
//    }
//}

extension FavoritesViewController {
    class func buildGridList() -> FavoritesViewController {
        let adapter = FavoriteGridListAdapter()
        let service = MoviesDetailWebService(idMovie: "", language: LocalizationManager.shared.get())
//        let navStyle =  NavigationBarTitle(title: "Cinemark")
        let error = ErrorView()
        let searchBarAdapter = SearchBarRealaseDate()
        let view = FavoritesView(listAdapter: adapter, favoritesSearchAdapter: searchBarAdapter)
        let favoriteService = FavoriteMovieService(repository: FavoriteMoviesDataRepository())
//        let local = FavoritesLocalStorageMock()
        let controller = FavoritesViewController(favoritesView: view, service: service, favoriteService: favoriteService, errorView: error)
        return controller
    }
}
