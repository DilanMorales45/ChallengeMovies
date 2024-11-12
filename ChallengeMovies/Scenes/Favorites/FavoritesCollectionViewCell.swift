//
//  FavoritesCollectionViewCell.swift
//  CollectionViewDemoSwiftBeta
//
//  Created by Dilan Alejandro Morales Estupinan on 10/11/24.
//

import UIKit

class FavoritesCollectionViewCell: UICollectionViewCell {
    
    private lazy var stackMovie: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var imageStackFavorite: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        return imageView
    }()
    
    private lazy var labelStackFavorite: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24)
        label.textAlignment = .left
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(stackMovie)
        stackMovie.addArrangedSubview(imageStackFavorite)
        stackMovie.addArrangedSubview(labelStackFavorite)
        
        NSLayoutConstraint.activate([
            stackMovie.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stackMovie.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            stackMovie.topAnchor.constraint(equalTo: topAnchor),
            stackMovie.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
          NSLayoutConstraint.activate([
              imageStackFavorite.topAnchor.constraint(equalTo: stackMovie.topAnchor, constant: 16)
          ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(model: Device) {
        imageStackFavorite.image = UIImage(systemName: model.imageName)
        labelStackFavorite.text = model.title
    }
}
