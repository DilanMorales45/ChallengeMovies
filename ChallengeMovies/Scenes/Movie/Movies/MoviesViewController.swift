//
//  MoviesViewController.swift
//  ChallengeMovies
//
//  Created by Mario Alfonso Orozco Pacheco on 11/11/24.
//

import UIKit

class MoviesViewController: UIViewController {
    
    private let moviesView: MoviesView
    private let navigationStyle: NavigationBarStyle
    
    init(moviesView: MoviesView, navigationStyle: NavigationBarStyle) {
        self.moviesView = moviesView
        self.navigationStyle = navigationStyle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.viewWillAppear(animated)
        self.fetchMovies()
    }
    
    private func configureView() {
        self.view = self.moviesView
    }
    
    private func fetchMovies() {
        let movies = [commonDetails.mock,commonDetails.mock, commonDetails.mock, commonDetails.mock, commonDetails.mock, commonDetails.mock, commonDetails.mock]
        self.moviesView.reloadData(movies)
    }
    
}

extension MoviesViewController {
    
    class func buildSimpleList() -> MoviesViewController {
        let adapter = MoviesSimpleListAdapter()
        let navStyle = NavigationBarHide()
        let view = moviesView(listAdapter: adapter)
        let controller = MoviesViewController(moviesView: view, navigationStyle: navStyle)
        return controller
    }
    
}
