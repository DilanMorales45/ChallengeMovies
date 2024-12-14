//
//  ListAdapter.swift
//  ChallengeMovies
//
//  Created by Dilan Alejandro Morales Estupinan on 28/11/24.
//

import UIKit

protocol ListAdapter: AnyObject {
    typealias DidSelectItem = (_ movie: commonDetails) -> Void
    var datasource: [commonDetails] { get set }
    var didSelectItem: DidSelectItem? { get set }
    func setCollectionView(_ collectionView: UICollectionView)
    
}

