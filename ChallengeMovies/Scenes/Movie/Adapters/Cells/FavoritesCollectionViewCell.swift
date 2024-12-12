//
//  FavoritesCollectionViewCell.swift
//  CollectionViewDemoSwiftBeta
//
//  Created by Dilan Alejandro Morales Estupinan on 10/11/24.
//

import UIKit

class FavoritesCollectionViewCell: UICollectionViewCell {
    
    private var movie: commonDetails?
    
    private lazy var lblInfo: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        lbl.textColor = UIColor(named: "text_white_lightgray_favorite")
        lbl.font = .systemFont(ofSize: 18, weight: .semibold)
//        lbl.heightAnchor.constraint(equalToConstant: 30).isActive = true
        return lbl
    }()
    
    private lazy var lblReleaseDate: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        lbl.font = UIFont.italicSystemFont(ofSize: 15)
        lbl.textColor = UIColor(named: "text_white_lightgray_label_favorite")
        return lbl
    }()
    
    private lazy var imgMovie: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.backgroundColor = .systemIndigo
        img.heightAnchor.constraint(equalTo: img.widthAnchor, multiplier: 1.5).isActive = true
        return img
    }()
    
    private lazy var stkContent2 = VerticalStack(subViews: [self.lblInfo, self.lblReleaseDate], spacing: 1)
    private lazy var stkContent = VerticalStack(subViews: [self.imgMovie,self.stkContent2], spacing: 1)
    
    private func setupCell() {
        
        self.backgroundColor = .clear
        self.stkContent.backgroundColor = UIColor(named: "cell_background_favorite")
        self.imgMovie.layer.cornerRadius = 8
        self.addSubview(self.stkContent)
        
        NSLayoutConstraint.activate([
            self.stkContent.topAnchor.constraint(equalTo: self.topAnchor),
            self.stkContent.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.stkContent.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.stkContent.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateWith(_ movie: commonDetails) {
        self.movie = movie
        self.lblInfo.text = movie.info
        self.lblReleaseDate.text = movie.releaseDateShortFormat
        self.imgMovie.loadImageIn(movie.posterPath) { image, urlString in
            if urlString == self.movie?.posterPath {
                self.imgMovie.image = image
            }
        }
    }
}

extension FavoritesCollectionViewCell {
    
    class var identifier: String { "FavoritesCollectionViewCell" }
    
    class func buildIn(_ collectionView: UICollectionView, indexPath: IndexPath, movie: commonDetails) -> Self {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.identifier, for: indexPath) as? Self
        cell?.updateWith(movie)
        return cell ?? Self()
    }
}
