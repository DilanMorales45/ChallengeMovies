//
//  MoviesView.swift
//  ChallengeMovies
//
//  Created by Mario Alfonso Orozco Pacheco on 8/11/24.
//

import UIKit

@objc protocol MoviesViewDelegate: AnyObject {
    @objc optional func moviesViewBeginPullToRefrsh(_ view: MoviesView)
    func moviesView(_ view: MoviesView, didSelector movies: commonDetails)
}

class MoviesView: UIView {
    
    weak var delegate: MoviesViewDelegate?
    
    // MARK: - UI Components
    let searchBarView = SearchBarView()
    let errorView = ErrorView()
    var listAdapter: ListAdapter
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private lazy var refreshControl: UIRefreshControl = {
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(pullToRefresh(_ :)) , for: .valueChanged)
        return refresh
    }()
    
    // MARK: - Initializer
    init(listAdapter: ListAdapter) {
        self.listAdapter = listAdapter
        super.init(frame: .zero)
        self.setupViews()
        self.configureAdapters()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Method
    private func setupViews() {
        self.addSubview(searchBarView)
        self.searchBarView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(collectionView)
        self.addSubview(errorView)
        self.errorView.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .white
        NSLayoutConstraint.activate([
            self.searchBarView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            self.searchBarView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.searchBarView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.searchBarView.bottomAnchor.constraint(equalTo: self.collectionView.topAnchor),
            self.collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.errorView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.errorView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.errorView.topAnchor.constraint(equalTo: self.collectionView.topAnchor),
            self.errorView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        self.errorView.isHidden = true
    }
    
    private func configureAdapters() {
        self.listAdapter.setCollectionView(self.collectionView)
    }
    
    func showError(_ show: Bool, searchText: String) {
        if show {
            self.errorView.updateErrorMessage(searchText: searchText)
            self.errorView.isHidden = false
        } else {
            self.errorView.isHidden = true
        }
    }
    
    // MARK: - Setup Method
    func reloadCollectionView(_ datasource: [commonDetails], searchText: String?) {
        self.listAdapter.datasource = datasource
        self.collectionView.reloadData()
        self.showError(datasource.isEmpty, searchText: searchText ?? "")
    }
    
    func addPullToRefresh() {
        self.collectionView.addSubview(self.refreshControl)
    }
    
    func endRefreshingAnimation() {
        self.refreshControl.endRefreshing()
    }
    
    @objc func pullToRefresh(_ sender: UIRefreshControl){
        self.delegate?.moviesViewBeginPullToRefrsh?(self)
//        self.delegate?.moviesView(MoviesView, didSelector: commonDetails)
    }
}
