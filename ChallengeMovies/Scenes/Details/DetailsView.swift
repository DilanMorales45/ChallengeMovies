//
//  DetailsViewNew.swift
//  ChallengeMovies
//
//  Created by Mario Alfonso Orozco Pacheco on 15/12/24.
//

import UIKit
import SwiftUI

class DetailsView: UIView {
    
    private lazy var mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .systemRed
        return imageView
    }()
    
    private lazy var innerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .center
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: 140).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 220).isActive = true
        imageView.layer.cornerRadius = 10
        imageView.backgroundColor = .blue
        return imageView
    }()
    
    private lazy var titleMovie: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        label.font = .systemFont(ofSize: 30, weight: .semibold)
        label.text = "Lightyear"
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var launchMovie: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        label.text = "Fecha de Lanzamiento"
        label.textColor = .lightGray
        label.font = UIFont.italicSystemFont(ofSize: 17)
        label.numberOfLines = 0
        return label
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
    
    private lazy var titleGender: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Generos:"
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .textWhite
        return label
    }()
    
    private lazy var genders: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "accion,comedia"
        label.textColor = .lightGray
        label.font = UIFont.italicSystemFont(ofSize: 17)
        return label
    }()
    
    private lazy var descriptionMovie: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Descipcion"
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .textWhite
        return label
    }()
    
    private lazy var descriptions: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "esta pelicula es muy bonita"
        label.textColor = .lightGray
        label.font = UIFont.italicSystemFont(ofSize: 17)
        return label
    }()
    
    private lazy var stkContentImage = HorizontalStack(subViews: [self.innerImageView, self.stkContentTitleInfo], distribution: .fill, spacing: 8)
    
    private lazy var stkContentTitleInfo = VerticalStack(subViews: [self.titleMovie, self.launchMovie, self.stkStars], spacing: 2, distribution: .fill)
    
    private lazy var stkContentGender = VerticalStack(subViews: [self.titleGender, self.genders], spacing: 5)
    
    private lazy var stkContentDescription = VerticalStack(subViews: [self.descriptionMovie, self.descriptions], spacing: 5)
    
    init() {
        super.init(frame: .zero)
        self.addElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addElements() {
        self.backgroundColor = UIColor(named: "background_dark_white")
        self.addSubview(self.mainImageView)
        
        self.mainImageView.addSubview(self.stkContentImage)
        self.addSubview(self.stkContentGender)
        self.addSubview(self.stkContentDescription)
        
        NSLayoutConstraint.activate([
            self.mainImageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            self.mainImageView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            self.mainImageView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            self.mainImageView.widthAnchor.constraint(equalToConstant: 400),
            self.mainImageView.heightAnchor.constraint(equalToConstant: 200),
            
            
            self.stkContentImage.leadingAnchor.constraint(equalTo: mainImageView.leadingAnchor,constant: 15),
            self.stkContentImage.trailingAnchor.constraint(equalTo: mainImageView.trailingAnchor),
            self.stkContentImage.topAnchor.constraint(equalTo: mainImageView.topAnchor,constant: 10),
            self.stkContentImage.bottomAnchor.constraint(equalTo: mainImageView.bottomAnchor, constant: -10),
            
            self.stkContentGender.topAnchor.constraint(equalTo: self.mainImageView.bottomAnchor, constant: 15),
            self.stkContentGender.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.stkContentGender.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            self.stkContentDescription.topAnchor.constraint(equalTo: self.stkContentGender.bottomAnchor, constant: 35),
            self.stkContentDescription.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.stkContentDescription.trailingAnchor.constraint(equalTo: self.trailingAnchor)
            
        ])
        self.stkStars.widthAnchor.constraint(equalTo: self.stkContentTitleInfo.widthAnchor, multiplier: 0.7).isActive = true
    }
    
    func updateWith(_ movie: commonDetails) {
        
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

struct DetailsViewNewRepresentable: UIViewRepresentable {
    func makeUIView(context: Context) -> DetailsView {
        let view = DetailsView()
        return view
    }
    
    func updateUIView(_ uiView: DetailsView, context: Context) { }
}

struct DetailsViewNewPreview: PreviewProvider {
    static var previews: some View { DetailsViewNewRepresentable() }
}
