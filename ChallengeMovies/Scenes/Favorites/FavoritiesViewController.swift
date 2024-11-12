//
//  FavoritiesViewController.swift
//  ChallengeMovies
//
//  Created by Mario Alfonso Orozco Pacheco on 8/11/24.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    private let favoritesView = FavoritesView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        view.addSubview(favoritesView)
        
    }
    
    private func setupCollectionView() {
        favoritesView.collectionView.dataSource = self
        favoritesView.collectionView.register(FavoritesCollectionViewCell.self, forCellWithReuseIdentifier: "FavoritesCollectionViewCell")
    }
}

extension FavoritesViewController: UICollectionViewDataSource {
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

