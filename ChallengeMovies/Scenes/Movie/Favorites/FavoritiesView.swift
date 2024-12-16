//
//  FavoritiesView.swift
//  ChallengeMovies
//
//  Created by Dilan Alejandro Morales Estupinan on 12/11/24.
//

import UIKit

protocol FavoritesViewDelegate: AnyObject {
    func favoritesView(_ view: FavoritesView, didSelector movies: commonDetails)
}

class FavoritesView: UIView {
    
    weak var delegate: FavoritesViewDelegate?
    
    // MARK: - UI Components
    let searchBarView = SearchBarView()
    let errorView = ErrorView()
    private var listAdapter: ListAdapter
    private var favoritesSearchAdapter: SearchBarAdapter
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.keyboardDismissMode = .onDrag
        return collectionView
    }()
    
    // MARK: - Initializer
    init(listAdapter: ListAdapter, favoritesSearchAdapter: SearchBarAdapter) {
        self.listAdapter = listAdapter
        self.favoritesSearchAdapter = favoritesSearchAdapter
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
        searchBarView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(collectionView)
        self.addSubview(errorView)
        self.errorView.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = UIColor(named: "background_dark_white")
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
        self.favoritesSearchAdapter.setSearchBar(self.searchBarView.searchBar)
        self.favoritesSearchAdapter.didFilterItem = { result in
            self.reloadCollectionViewWith(result)
        }
    }
    
    func reloadData(_ datasource: [commonDetails]) {
        self.favoritesSearchAdapter.datasource = datasource
        self.reloadCollectionViewWith(datasource)
    }
    
    func reloadCollectionViewWith(_ datasource: [Any]) {
        self.listAdapter.datasource = datasource
        self.collectionView.reloadData()
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
//    func reloadCollectionView(_ datasource: [commonDetails], searchText: String?) {
//        self.listAdapter.datasource = datasource
//        self.collectionView.reloadData()
//        self.showError(datasource.isEmpty, searchText: searchText ?? "")
//    }
    
}
