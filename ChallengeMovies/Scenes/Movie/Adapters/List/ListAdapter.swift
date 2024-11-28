//
//  ListAdapter.swift
//  ChallengeMovies
//
//  Created by Dilan Alejandro Morales Estupinan on 28/11/24.
//

import UIKit

protocol ListAdapter: AnyObject {
    var datasource: [commonDetails] { get set }
    func setCollectionView(_ collectionView: UICollectionView)
}

