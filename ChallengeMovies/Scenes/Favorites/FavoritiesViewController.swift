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

    init(favoritesView: FavoritesView,navigationStyle: NavigationBarStyle) {
        self.favoritesView = favoritesView
        self.navigationStyle = navigationStyle
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
        self.favoritesView.collectionView.register(FavoritesCollectionViewCell.self, forCellWithReuseIdentifier: "FavoritesCollectionViewCell")
        
        self.filteredData = data
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationStyle.configure(self)
    }
    
    private func configure() {
        self.view = favoritesView
        self.favoritesView.backgroundColor = .white
        self.favoritesView.collectionView.dataSource = self
    }
    
    // MARK: - SearchBarViewDelegate
    
    func didUpdateSearchResults(searchText: String) {
        
        if searchText.isEmpty {
            filteredData = data
        } else {
            filteredData = data.filter { $0.title.lowercased().contains(searchText.lowercased()) }
        }
        
        favoritesView.reloadCollectionView()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return house.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavoritesCollectionViewCell", for: indexPath) as! FavoritesCollectionViewCell
        
        // Configura la apariencia de la celda
        cell.backgroundColor = .white
        cell.layer.cornerRadius = 20
        cell.layer.masksToBounds = true
        cell.layer.shadowColor = UIColor.gray.cgColor
        cell.layer.shadowOpacity = 0.4
        cell.layer.shadowOffset = CGSize(width: 0, height: 0)
        cell.layer.shadowRadius = 5
        
        let model = house[indexPath.row]
        cell.configure(model: model)
        
        return cell
    }

}

extension FavoritesViewController {
    class func build() -> FavoritesViewController {
        let view = FavoritesView()
        let controller = FavoritesViewController(favoritesView: view, navigationStyle: NavigationBarHide())
        return controller
    }
}
