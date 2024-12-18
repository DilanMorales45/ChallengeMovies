//
//  ErrorCollectionViewCell.swift
//  ChallengeMovies
//
//  Created by Mario Alfonso Orozco Pacheco on 13/12/24.
//

import UIKit

class ErrorCollectionViewCell: UICollectionViewCell, GenericCollectionViewCell {
    
    private lazy var lblInfo: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        lbl.textAlignment = .center
        lbl.textColor = UIColor(named: "text_white_lightgray_favorite")
        lbl.font = .systemFont(ofSize: 18, weight: .light)
        return lbl
    }()
    
    private lazy var imgIcon: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(systemName: "exclamationmark.triangle")
        img.translatesAutoresizingMaskIntoConstraints = false
        img.widthAnchor.constraint(equalToConstant: 70).isActive = true
        img.heightAnchor.constraint(equalTo: img.widthAnchor, constant: 0).isActive = true
        return img
    }()
    
    private lazy var stkContent = VerticalStack(subViews: [self.imgIcon, self.lblInfo],
                                                spacing: 30,
                                                alignment: .center,
                                                margins: UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30))
    
    private func setupCell() {
        
        self.backgroundColor = .clear
        self.stkContent.backgroundColor = UIColor(named: "cell_background_favorite")
        self.addSubview(self.stkContent)
        
        NSLayoutConstraint.activate([
            self.stkContent.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.stkContent.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.stkContent.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -50)
        ])
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateWith(_ data: Any) {
        guard let errorMessage = data as? String else { return }
        self.lblInfo.text = errorMessage
    }
}

extension ErrorCollectionViewCell {
    
    class var identifier: String { "ErrorCollectionViewCell" }
    
    class var layoutSection: NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 1)
            
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
}
