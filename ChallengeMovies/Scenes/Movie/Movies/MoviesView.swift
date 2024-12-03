//
//  MoviesView.swift
//  ChallengeMovies
//
//  Created by Mario Alfonso Orozco Pacheco on 8/11/24.
//

import UIKit

class MoviesView: UIView {
    
    // MARK: - UI Components
    let searchBarView = SearchBarView()
    let errorView = ErrorView()
    var listAdapter: ListAdapter
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 19)
        label.text = "Cinemark"
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var configurationButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.image = UIImage(systemName: "ellipsis")
        config.baseForegroundColor = .gray
        
        let button = UIButton(type: .system)
        button.configuration = config
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
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
        self.addSubview(titleLabel)
        self.addSubview(configurationButton)
        self.addSubview(searchBarView)
        self.searchBarView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(collectionView)
        self.addSubview(errorView)
        self.errorView.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .white
        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            self.titleLabel.widthAnchor.constraint(equalToConstant: 370),
            self.titleLabel.heightAnchor.constraint(equalToConstant: 40),
            self.titleLabel.bottomAnchor.constraint(equalTo: searchBarView.topAnchor),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.configurationButton.leadingAnchor),
            self.configurationButton.topAnchor.constraint(equalTo: self.titleLabel.topAnchor),
            self.configurationButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            self.configurationButton.bottomAnchor.constraint(equalTo: searchBarView.topAnchor),
            self.searchBarView.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor),
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
    
    // MARK: - Set Title
    func setTitle(_ title: String) {
        self.titleLabel.text = title
    }
}
