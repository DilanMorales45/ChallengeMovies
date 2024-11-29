//
//  MoviesCollectionViewCell.swift
//  TryChallengeMovies
//
//  Created by Mario Alfonso Orozco Pacheco on 10/11/24.
//

import UIKit

class MoviesCollectionViewCell: UICollectionViewCell {
    
    private lazy var lblInfo: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        lbl.textColor = .darkGray
        lbl.font = .systemFont(ofSize: 18, weight: .semibold)
        return lbl
    }()

    private lazy var lblReleaseDateInfo: UILabel = {
        let lbl = UILabel()
        lbl.text = "Fecha de lanzamiento:"
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        lbl.textColor = .darkGray
        lbl.font = .systemFont(ofSize: 15, weight: .light)
        return lbl
    }()
    
    private lazy var lblReleaseDate: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        lbl.textColor = .darkGray
        lbl.font = .systemFont(ofSize: 15, weight: .light)
        return lbl
    }()
    
    private lazy var imgMovie: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.backgroundColor = .systemIndigo
        img.widthAnchor.constraint(equalToConstant: 120).isActive = true
        img.heightAnchor.constraint(equalTo: img.widthAnchor, multiplier: 1.5).isActive = true
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
        self.stkContent.backgroundColor = .white
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = 5
        self.layer.shadowOpacity = 0.3
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
    
    func updateWith(_ movie: commonDetails) {
        self.lblInfo.text = movie.info
        self.lblReleaseDate.text = movie.releaseDateFullFormat
        
        self.updateStars(rating: movie.rating)
    }
    
    // Método para actualizar las estrellas
       func updateStars(rating: Double) {
           // Limpiar cualquier imagen previa
           self.stkStars.arrangedSubviews.forEach { $0.removeFromSuperview() }
           
           // Calcular cuántas estrellas completas, medias y vacías deben mostrarse
           let fullStars = Int(rating)
           let hasExtraFullStar = (rating - Double(fullStars)) >= 0.5 ? 1 : 0
           let emptyStars = 10 - (fullStars + hasExtraFullStar)
           
           // Crear un arreglo con las imágenes a agregar
           let starImages = Array(repeating: UIImage(systemName: "star.fill"), count: fullStars + hasExtraFullStar) +
                            Array(repeating: UIImage(systemName: "star"), count: emptyStars)
           
           // Tamaño de las estrellas (ajustado a un tamaño más pequeño)
           let starSize: CGFloat = 15 // Ajusta este valor para cambiar el tamaño de las estrellas

           // Agregar las imágenes al starStackView
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
