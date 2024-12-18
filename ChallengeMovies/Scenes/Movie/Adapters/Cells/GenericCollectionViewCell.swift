//
//  GenericCollectionViewCell.swift
//  ChallengeMovies
//
//  Created by Mario Alfonso Orozco Pacheco on 15/12/24.
//

import UIKit

protocol GenericCollectionViewCell: UICollectionViewCell {
    static var identifier: String { get }
    static var layoutSection: NSCollectionLayoutSection { get }
    func updateWith(_ data: Any)
    static func buildIn(_ collectionView: UICollectionView, indexPath: IndexPath, data: Any) -> Self
}

extension GenericCollectionViewCell {
    static func buildIn(_ collectionView: UICollectionView, indexPath: IndexPath, data: Any) -> Self {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.identifier, for: indexPath) as? Self
        cell?.updateWith(data)
        return cell ?? Self()
    }
}
