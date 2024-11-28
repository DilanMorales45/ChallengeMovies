//
//  FavoritiesViewController.swift
//  ChallengeMovies
//
//  Created by Mario Alfonso Orozco Pacheco on 8/11/24.
//

import UIKit

class FavoritesViewController: UIViewController, SearchBarViewDelegate, UICollectionViewDataSource {
    
    // MARK: - Properties
    var data = house
    var filteredData: [Device] = []
    private let favoritesView: FavoritesView
    private let navigationStyle: NavigationBarStyle
    private let errorView: ErrorView

    init(favoritesView: FavoritesView,navigationStyle: NavigationBarStyle,errorView: ErrorView) {
        self.favoritesView = favoritesView
        self.navigationStyle = navigationStyle
        self.errorView = errorView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle Methods
    override func loadView() {
        self.configureView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.favoritesView.setTitle("Cinemark")
        self.favoritesView.collectionView.register(FavoritesCollectionViewCell.self, forCellWithReuseIdentifier: "FavoritesCollectionViewCell")
        
        self.filteredData = data
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationStyle.configure(self)
    }
    
    private func configureView() {
        self.view = favoritesView
        self.favoritesView.searchBarView.delegate = self
        self.favoritesView.collectionView.dataSource = self
    }
    
    // MARK: - SearchBarViewDelegate
    
    func didUpdateSearchResults(searchText: String) {
        
        if searchText.isEmpty {
            filteredData = data
        } else {
            filteredData = data.filter { $0.title.lowercased().contains(searchText.lowercased()) }
        }
        
        if filteredData.isEmpty {
            showErrorView(searchText: searchText)
        } else {
            showCollectionView()
        }
        
        favoritesView.reloadCollectionView()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavoritesCollectionViewCell", for: indexPath) as! FavoritesCollectionViewCell
        
        
        let model = filteredData[indexPath.row]
        cell.configure(model: model)
        
        cell.backgroundColor = .white
        cell.layer.cornerRadius = 20
        cell.layer.masksToBounds = true
        cell.layer.shadowColor = UIColor.gray.cgColor
        cell.layer.shadowOpacity = 0.4
        cell.layer.shadowOffset = CGSize(width: 0, height: 0)
        cell.layer.shadowRadius = 5
        
        return cell
    }

    private func showErrorView (searchText: String) {
        
        errorView.updateErrorMessage(searchText: searchText)
        
        favoritesView.collectionView.isHidden = true
        favoritesView.addSubview(errorView)
        
        errorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            errorView.topAnchor.constraint(equalTo: favoritesView.searchBarView.bottomAnchor),
            errorView.leadingAnchor.constraint(equalTo: favoritesView.safeAreaLayoutGuide.leadingAnchor),
            errorView.trailingAnchor.constraint(equalTo: favoritesView.safeAreaLayoutGuide.trailingAnchor),
            errorView.bottomAnchor.constraint(equalTo: favoritesView.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    private func showCollectionView () {
        errorView.removeFromSuperview()
        favoritesView.collectionView.isHidden = false
        favoritesView.reloadCollectionView()
    }
}

extension FavoritesViewController {
    class func build() -> FavoritesViewController {
        let view = FavoritesView()
        let controller = FavoritesViewController(favoritesView: view, navigationStyle: NavigationBarHide(), errorView: ErrorView())
        return controller
    }
}