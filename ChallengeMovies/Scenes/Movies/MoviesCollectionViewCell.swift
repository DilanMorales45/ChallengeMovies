//
//  MoviesCollectionViewCell.swift
//  TryChallengeMovies
//
//  Created by Mario Alfonso Orozco Pacheco on 10/11/24.
//

import UIKit

class MoviesCollectionViewCell: UICollectionViewCell {
    
    private lazy var StackMovie: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
//        stackView.layer.cornerRadius = 20
//        stackView.layer.masksToBounds = true
        stackView.spacing = 8  // Espacio entre la imagen y el texto
        stackView.translatesAutoresizingMaskIntoConstraints = false
//        stackView.layer.borderColor = UIColor.gray.cgColor
//        stackView.layer.borderWidth = 1
        return stackView
    }()
    
    private lazy var ImageStackMovie: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .center
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return imageView
    }()
    
    private lazy var LabelStackMoviee: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24)
        label.textAlignment = .left
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        addSubview(StackMovie)
        StackMovie.addArrangedSubview(ImageStackMovie)
        StackMovie.addArrangedSubview(LabelStackMoviee)
        
        NSLayoutConstraint.activate([
            StackMovie.leadingAnchor.constraint(equalTo: leadingAnchor),
            StackMovie.trailingAnchor.constraint(equalTo: trailingAnchor),
            StackMovie.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            StackMovie.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(model: Device) {
        ImageStackMovie.image = UIImage(systemName: model.imageName)
        LabelStackMoviee.text = model.title
    }
    
}
