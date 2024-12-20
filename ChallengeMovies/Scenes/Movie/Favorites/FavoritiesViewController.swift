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
    private let service: MoviesWebServiceProtocol
//    private let navigationStyle: NavigationBarStyle
    private let localStorage: FavoritesLocalStorageProtocol
    
    init(favoritesView: FavoritesView, service: MoviesWebServiceProtocol,  errorView: ErrorView, localStorage: FavoritesLocalStorageProtocol) {
        self.favoritesView = favoritesView
        self.service = service
//        self.navigationStyle = navigationStyle
        self.errorView = errorView
        self.localStorage = localStorage
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
        self.fetchMovies()
    }
    
    private func configureView() {
        self.view = self.favoritesView
        self.favoritesView.delegate = self
    }
    
    private func fetchMovies() {
        //        self.service.fetch { moviesDTO in
        //            self.favoritesView.reloadCollectionView(moviesDTO.toMovies, searchText: nil)
        //        }
        let result = self.localStorage.fetch()
        self.favoritesView.reloadData(result.toMovies)
        //        self.allMovies = movies
        //        self.filteredMovies = movies
        //        self.favoritesView.reloadCollectionView(movies, searchText: nil)
    }
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
        let service = MoviesWebService(language: LocalizationManager.shared.get())
//        let navStyle =  NavigationBarTitle(title: "Cinemark")
        let error = ErrorView()
        let searchBarAdapter = SearchBarRealaseDate()
        let view = FavoritesView(listAdapter: adapter, favoritesSearchAdapter: searchBarAdapter)
        let local = FavoritesLocalStorageMock()
        let controller = FavoritesViewController(favoritesView: view, service: service, errorView: error, localStorage: local)
        return controller
    }
}
