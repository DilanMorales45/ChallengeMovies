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
    private let service: MoviesWebServiceProtocol
//    private let navigationStyle: NavigationBarStyle
    
    init(moviesView: MoviesView, service: MoviesWebServiceProtocol,  errorView: ErrorView) {
        self.moviesView = moviesView
        self.service = service
//        self.navigationStyle = navigationStyle
        self.errorView = errorView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
        self.fetchMovies()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.navigationStyle.configure(self)
    }
    
    private func configureView() {
        self.view = self.moviesView
        self.moviesView.backgroundColor = UIColor(named: "background_dark_white")
        self.moviesView.delegate = self
        if let adapter = self.moviesView.listAdapter as? MoviesSimpleListAdapter {
            adapter.delegate = self
        }
        self.moviesView.addPullToRefresh()
    }
    
    private func fetchMovies() {
        self.service.fetch { moviesDTO in
            self.moviesView.endRefreshingAnimation()
            self.moviesView.reloadData(moviesDTO.toMovies)
        }
//        self.allMovies = movies
//        self.filteredMovies = movies
//        self.moviesView.reloadCollectionView(movies, searchText: nil)
    }
    
}

extension MoviesViewController: MoviesViewDelegate {
    func moviesViewBeginPullToRefrsh(_ view: MoviesView) {
        self.fetchMovies()
    }
    
    func moviesView(_ view: MoviesView, didSelector movies: commonDetails) {
        let controller = DetailsViewController.buildWith(movies)
        self.navigationController?.pushViewController(controller, animated: true)
        print(movies.title)
        print(movies.id)
    }
    
    
}

//extension MoviesViewController: SearchBarViewDelegate {
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
//        self.moviesView.reloadCollectionView(filteredMovies, searchText: searchText)
//    }
//}
//
extension MoviesViewController: MoviesSimpleListAdapterDelegate {
    
    func didSelectMovie(_ movie: commonDetails) {
        print(movie.title)
    }
    
    
    
//    func didSelectMovie(_ movie: commonDetails) {
//        let detailsController = DetailsViewController.build()
//        // Aquí puedes pasar datos a `detailsController` si es necesario, como `movie` para configurar la vista.
////        detailsController.detailsView.configure(with: movie)
//        self.navigationController?.pushViewController(detailsController, animated: true)
//    }
}

extension MoviesViewController {
    
    class func buildSimpleList() -> MoviesViewController {
        let adapter = MoviesSimpleListAdapter()
        let service = MoviesWebService(language: LocalizationManager.shared.get())
//        let navStyle = NavigationBarTitle(title: "Cinemark")
        let error = ErrorView()
        let searchBarAdapter = SearchBarTitleAdapter()
        let view = MoviesView(listAdapter: adapter, moviesSearchAdapter: searchBarAdapter)
        let controller = MoviesViewController(moviesView: view, service: service , errorView: error)
        return controller
    }
    
}
