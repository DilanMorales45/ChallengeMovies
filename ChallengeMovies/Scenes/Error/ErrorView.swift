//
//  ErrorView.swift
//  ChallengeMovies
//
//  Created by Dilan Alejandro Morales Estupinan on 14/11/24.
//

import UIKit

class ErrorView: UIView {
    
    private let errorIconImageView: UIImageView = {
        let imageError = UIImageView()
        imageError.image = UIImage(systemName: "exclamationmark.triangle")
        imageError.contentMode = .scaleAspectFit
        return imageError
    }()
    
    private let keySearchLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        label.text = "La llave de la búsqueda tiene que ir acá"
        label.font = UIFont.italicSystemFont(ofSize: 17)
        label.textColor = .gray
        label.numberOfLines = 0
        return label
    }()
    
    private let errorMessageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        label.text = "No se encontraron resultados para la búsqueda de:"
        label.font = UIFont.italicSystemFont(ofSize: 17)
        label.textColor = .gray
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        self.backgroundColor = .white
        addSubview(errorIconImageView)
        
        let stackView = UIStackView(arrangedSubviews: [errorMessageLabel, keySearchLabel])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        
        errorIconImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            errorIconImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            errorIconImageView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -20),
            errorIconImageView.widthAnchor.constraint(equalToConstant: 50),
            errorIconImageView.heightAnchor.constraint(equalToConstant: 50),
            
            stackView.topAnchor.constraint(equalTo: errorIconImageView.bottomAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
}
