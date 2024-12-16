//
//  MoviesCollectionViewCell.swift
//  TryChallengeMovies
//
//  Created by Mario Alfonso Orozco Pacheco on 10/11/24.
//

import UIKit

class MoviesCollectionViewCell: UICollectionViewCell, GenericCollectionViewCell {
    
    private var movie: commonDetails?
    
    private lazy var lblInfo: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        lbl.textColor = UIColor(named: "text_white_lightgray_title_movie")
        lbl.font = .systemFont(ofSize: 19, weight: .semibold)
        return lbl
    }()

    private lazy var lblReleaseDateInfo: UILabel = {
        let lbl = UILabel()
        lbl.text = "Fecha de lanzamiento:"
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        lbl.textColor = UIColor(named: "text_white_lightgray_label_movie")
        lbl.font = UIFont.italicSystemFont(ofSize: 15)
        return lbl
    }()
    
    private lazy var lblReleaseDate: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        lbl.textColor = UIColor(named: "text_white_lightgray_label_movie")
        lbl.font = UIFont.italicSystemFont(ofSize: 15)
        return lbl
    }()
    
    private lazy var imgMovie: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.backgroundColor = .systemIndigo
        img.widthAnchor.constraint(equalToConstant: 120).isActive = true
        img.heightAnchor.constraint(equalTo: img.widthAnchor, multiplier: 1.5).isActive = true
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        return img
    }()

    private lazy var stkStars: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 0
        stackView.alignment = .leading
        stackView.distribution = .fillEqually
        return stackView
    }()

    private lazy var stkReleaseDate = VerticalStack(subViews: [self.lblReleaseDateInfo, self.lblReleaseDate], spacing: 3)
    private lazy var stkInfo = VerticalStack(subViews: [self.lblInfo, self.stkReleaseDate, self.stkStars],
                                             spacing: 3,
                                             margins: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
    private lazy var stkContent = HorizontalStack(subViews: [self.imgMovie, self.stkInfo], distribution: .fill, spacing: 0)
    
    private func setupCell() {
        
        self.backgroundColor = .clear
        self.stkContent.backgroundColor =  UIColor(named: "cell_background_movies")
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = 5
        self.layer.shadowOpacity = 0.5
        self.stkContent.layer.cornerRadius = 8
        self.stkContent.clipsToBounds = true
        self.addSubview(self.stkContent)
        
        NSLayoutConstraint.activate([
            self.stkContent.topAnchor.constraint(equalTo: self.topAnchor),
            self.stkContent.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.stkContent.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.stkContent.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
        self.stkStars.widthAnchor.constraint(equalTo: self.stkInfo.widthAnchor, multiplier: 0.7).isActive = true

    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateWith(_ data: Any) {
        guard let movie = data as? commonDetails else { return }
        self.movie = movie
        self.lblInfo.text = movie.info
        self.lblReleaseDate.text = movie.releaseDateFullFormat
        self.imgMovie.loadImageIn(movie.posterPath) { image, urlString in
            if urlString == self.movie?.posterPath {
                self.imgMovie.image = image
            }
        }
        self.updateStars(rating: movie.voteAverage)
    }
    
    func updateStars(rating: Double) {
        self.stkStars.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        let fullStars = Int(rating)
        let hasExtraFullStar = (rating - Double(fullStars)) >= 0.5 ? 1 : 0
        let emptyStars = 10 - (fullStars + hasExtraFullStar)
        
        let starImages = Array(repeating: UIImage(systemName: "star.fill"), count: fullStars + hasExtraFullStar) +
        Array(repeating: UIImage(systemName: "star"), count: emptyStars)
        
        let starSize: CGFloat = 15
        
        starImages.forEach { image in
            let imageView = UIImageView(image: image)
            imageView.tintColor = .systemOrange // Color amarillo
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.widthAnchor.constraint(equalToConstant: starSize).isActive = true
            imageView.heightAnchor.constraint(equalToConstant: starSize).isActive = true
            self.stkStars.addArrangedSubview(imageView)
        }
    }
}

extension MoviesCollectionViewCell {
    
    class var identifier: String { "MoviesCollectionViewCell" }
    
    class var layoutSection: NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(140))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(140))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 1)
            
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 12
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15)
        
        return section
    }

}
