//
//  FavoriteGridListAdapter.swift
//  ChallengeMovies
//
//  Created by Dilan Alejandro Morales Estupinan on 28/11/24.
//

import UIKit

class FavoriteGridListAdapter: NSObject, ListAdapter {
    var didSelectItem: DidSelectItem?
    
    private weak var collectionView: UICollectionView?
    var datasource: [Any] = []
    
    func setCollectionView(_ collectionView: UICollectionView) {
        self.collectionView = collectionView
        self.collectionView?.delegate = self
        self.collectionView?.dataSource = self
        self.collectionView?.register(FavoritesCollectionViewCell.self, forCellWithReuseIdentifier: FavoritesCollectionViewCell.identifier)
        self.collectionView?.register(ErrorCollectionViewCell.self, forCellWithReuseIdentifier: ErrorCollectionViewCell.identifier)
//        self.collectionView?.collectionViewLayout = self.layout()
        self.setLayout()
    }
    
    private func setLayout() {
        let layout = UICollectionViewCompositionalLayout { section, layoutEnv in
            (self.datasource is [commonDetails]) ? FavoritesCollectionViewCell.layoutSection : ErrorCollectionViewCell.layoutSection
        }
        self.collectionView?.collectionViewLayout = layout
    }
}

extension FavoriteGridListAdapter: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.datasource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = self.datasource[indexPath.row]
        let factory = Factory(item: item)
        return factory.cell.buildIn(collectionView, indexPath: indexPath, data: item)
    }
}

extension FavoriteGridListAdapter: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let movie = self.datasource[indexPath.row] as? commonDetails else { return }
        self.didSelectItem?(movie)
    }
}

extension FavoriteGridListAdapter {
    
    fileprivate struct Factory {
        
        private let typeCell: Cell
        
        init(item: Any) {
            self.typeCell = Cell(item: item)
        }
        
        var cell: GenericCollectionViewCell.Type {
            switch self.typeCell {
            case .movie: return FavoritesCollectionViewCell.self
            case .error: return ErrorCollectionViewCell.self
            }
        }
    }
}

extension FavoriteGridListAdapter.Factory {
    fileprivate enum Cell {
        case movie
        case error
        
        init(item: Any) {
            switch item {
            case is commonDetails:
                self = .movie
            case is String:
                self = .error
            default:
                self = .error
            }
        }
    }
}
