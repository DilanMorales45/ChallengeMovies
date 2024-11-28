//
//  FavoriteGridListAdapter.swift
//  ChallengeMovies
//
//  Created by Dilan Alejandro Morales Estupinan on 28/11/24.
//

import UIKit

class FavoriteGridListAdapter: NSObject, ListAdapter {
    
    private weak var collectionView: UICollectionView?
    var datasource: [commonDetails] = []
    
    func setCollectionView(_ collectionView: UICollectionView) {
        self.collectionView = collectionView
        self.collectionView?.delegate = self
        self.collectionView?.dataSource = self
        self.collectionView?.register(FavoritesCollectionViewCell().self, forCellWithReuseIdentifier: "FavoritesCollectionViewCell")
        self.collectionView?.collectionViewLayout = self.layout()
    }
    
    private func layout() -> UICollectionViewCompositionalLayout {
        let numberOfColumns: Int = 2
        let fractionalWidth: CGFloat = 1 / CGFloat(numberOfColumns)
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(fractionalWidth), heightDimension: .estimated(80))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(80))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: numberOfColumns)
        group.interItemSpacing = .fixed(8)
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 12
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}

extension FavoriteGridListAdapter: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.datasource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let movie = self.datasource[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavoritesCollectionViewCell", for: indexPath) as? FavoritesCollectionViewCell
        cell?.updateWith(movie)
        return cell ?? UICollectionViewCell()
    }
}

extension FavoriteGridListAdapter: UICollectionViewDelegate {
    
}
