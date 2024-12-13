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
    private let navigationStyle: NavigationBarStyle
    private var allMovies: [commonDetails] = []
    private var filteredMovies: [commonDetails] = []
    
    init(favoritesView: FavoritesView, service: MoviesWebServiceProtocol, navigationStyle: NavigationBarStyle, errorView: ErrorView) {
        self.favoritesView = favoritesView
        self.service = service
        self.navigationStyle = navigationStyle
        self.errorView = errorView
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
        self.navigationStyle.configure(self)
        self.fetchMovies()
    }
    
    private func configureView() {
        self.view = self.favoritesView
        self.favoritesView.searchBarView.delegate = self
    }
    
    private func fetchMovies() {
        self.service.fetch { moviesDTO in
            self.favoritesView.reloadCollectionView(moviesDTO.toMovies, searchText: nil)
        }
//        self.allMovies = movies
//        self.filteredMovies = movies
//        self.favoritesView.reloadCollectionView(movies, searchText: nil)
    }
}

extension FavoritesViewController: SearchBarViewDelegate {
    func didUpdateSearchResults(searchText: String) {
        if searchText.isEmpty {
            filteredMovies = allMovies
        } else {
            filteredMovies = allMovies.filter { movie in
                movie.title.lowercased().contains(searchText.lowercased()) ||
                String(movie.voteAverage).contains(searchText)
            }
        }
        
        self.favoritesView.reloadCollectionView(filteredMovies, searchText: searchText)
    }
}

extension FavoritesViewController {
    class func buildGridList() -> FavoritesViewController {
        let adapter = FavoriteGridListAdapter()
        let service = MoviesWebService()
        let navStyle =  NavigationBarTitle(title: "Cinemark")
        let error = ErrorView()
        let view = FavoritesView(listAdapter: adapter)
        let controller = FavoritesViewController(favoritesView: view, service: service, navigationStyle: navStyle, errorView: error)
        return controller
    }
}
