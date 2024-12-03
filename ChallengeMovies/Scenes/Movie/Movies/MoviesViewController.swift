//
//  MoviesViewController.swift
//  ChallengeMovies
//
//  Created by Mario Alfonso Orozco Pacheco on 11/11/24.
//

import UIKit

class MoviesViewController: UIViewController {
    
    private let moviesView: MoviesView
    private let errorView: ErrorView
    private let navigationStyle: NavigationBarStyle
    private var allMovies: [commonDetails] = []
    private var filteredMovies: [commonDetails] = []
    
    init(moviesView: MoviesView, navigationStyle: NavigationBarStyle, errorView: ErrorView) {
        self.moviesView = moviesView
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
        self.view = self.moviesView
        self.moviesView.searchBarView.delegate = self
        if let adapter = self.moviesView.listAdapter as? MoviesSimpleListAdapter {
            adapter.delegate = self
        }
    }
    
    private func configurationActions() {

    }
    
    private func fetchMovies() {
        let movies = [commonDetails.mock, commonDetails.init(nameMovie: "ruta", rating: 2.0, urlImage: "", releaseDate: "12/03/2020"), commonDetails.mock, commonDetails.mock, commonDetails.mock, commonDetails.mock, commonDetails.mock]
        self.allMovies = movies
        self.filteredMovies = movies
        self.moviesView.reloadCollectionView(movies, searchText: nil)
    }
    
}

extension MoviesViewController: SearchBarViewDelegate {
    func didUpdateSearchResults(searchText: String) {
        if searchText.isEmpty {
            filteredMovies = allMovies
        } else {
            filteredMovies = allMovies.filter { movie in
                movie.nameMovie.lowercased().contains(searchText.lowercased()) ||
                String(movie.rating).contains(searchText)
            }
        }
        
        self.moviesView.reloadCollectionView(filteredMovies, searchText: searchText)
    }
}

extension MoviesViewController: MoviesSimpleListAdapterDelegate {
    func didSelectMovie(_ movie: commonDetails) {
        let detailsController = DetailsViewController.build()
        // Aquí puedes pasar datos a `detailsController` si es necesario, como `movie` para configurar la vista.
//        detailsController.detailsView.configure(with: movie)
        self.navigationController?.pushViewController(detailsController, animated: true)
    }
}

extension MoviesViewController {
    
    class func buildSimpleList() -> MoviesViewController {
        let adapter = MoviesSimpleListAdapter()
        let navStyle = NavigationBarHide()
        let error = ErrorView()
        let view = MoviesView(listAdapter: adapter)
        let controller = MoviesViewController(moviesView: view, navigationStyle: navStyle, errorView: error)
        return controller
    }
    
}
