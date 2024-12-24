//
//  ListAdapter.swift
//  ChallengeMovies
//
//  Created by Dilan Alejandro Morales Estupinan on 28/11/24.
//

import UIKit

protocol ListAdapter: AnyObject {
    typealias DidSelectItem = (_ movie: commonDetails) -> Void
    typealias DidSelectItemFavorite = (_ movie: details) -> Void
    var datasource: [Any] { get set }
    var didSelectItem: DidSelectItem? { get set }
    var didSelectItemFavorite: DidSelectItemFavorite? { get set }
    func setCollectionView(_ collectionView: UICollectionView)
}

