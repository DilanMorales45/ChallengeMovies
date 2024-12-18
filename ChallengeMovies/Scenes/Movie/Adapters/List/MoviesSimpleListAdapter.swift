//
//  MoviesSimpleListAdapter.swift
//  ChallengeMovies
//
//  Created by Dilan Alejandro Morales Estupinan on 28/11/24.
//

import UIKit

protocol MoviesSimpleListAdapterDelegate: AnyObject {
    func didSelectMovie(_ movie: commonDetails)
}

class MoviesSimpleListAdapter: NSObject, ListAdapter {
    var didSelectItem: DidSelectItem?
    
    private weak var collectionView: UICollectionView?
    var datasource: [Any] = []
    weak var delegate: MoviesSimpleListAdapterDelegate?

    func setCollectionView(_ collectionView: UICollectionView) {
        self.collectionView = collectionView
        self.collectionView?.delegate = self
        self.collectionView?.dataSource = self
        self.collectionView?.register(MoviesCollectionViewCell.self, forCellWithReuseIdentifier: MoviesCollectionViewCell.identifier)
        self.collectionView?.register(ErrorCollectionViewCell.self, forCellWithReuseIdentifier: ErrorCollectionViewCell.identifier)
//        self.collectionView?.collectionViewLayout = self.layout()
        self.setLayout()
    }
    
    private func setLayout() {
        let layout = UICollectionViewCompositionalLayout { section, layoutEnv in
            (self.datasource is [commonDetails]) ? MoviesCollectionViewCell.layoutSection : ErrorCollectionViewCell.layoutSection
        }
        self.collectionView?.collectionViewLayout = layout
    }
}

extension MoviesSimpleListAdapter: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.datasource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = self.datasource[indexPath.row]
        let factory = Factory(item: item)
        return factory.cell.buildIn(collectionView, indexPath: indexPath, data: item)
    }
}

extension MoviesSimpleListAdapter: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let movie = self.datasource[indexPath.row] as? commonDetails else { return }
        self.didSelectItem?(movie)
    }
}

extension MoviesSimpleListAdapter {
    
    fileprivate struct Factory {
        
        private let typeCell: Cell
        
        init(item: Any) {
            self.typeCell = Cell(item: item)
        }
        
        var cell: GenericCollectionViewCell.Type {
            switch self.typeCell {
            case .movie: return MoviesCollectionViewCell.self
            case .error: return ErrorCollectionViewCell.self
            }
        }
    }
}

extension MoviesSimpleListAdapter.Factory {
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
