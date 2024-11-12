//
//  DetailsView.swift
//  ChallengeMovies
//
//  Created by Mario Alfonso Orozco Pacheco on 8/11/24.
//

import UIKit

class DetailView: UIView {
    
    private lazy var StackHorizontal: UIStackView = {
            let stackView = UIStackView()
            stackView.axis = .horizontal

            stackView.spacing = 8
            stackView.translatesAutoresizingMaskIntoConstraints = false
            return stackView
        }()
    private lazy var StackVertical: UIStackView = {
            let stackView = UIStackView()
            stackView.axis = .vertical
            stackView.spacing = 2
            stackView.translatesAutoresizingMaskIntoConstraints = false

            return stackView
        }()

    private let mainImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.backgroundColor = .lightGray
            return imageView
        }()
        
        private let innerImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.contentMode = .center
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.widthAnchor.constraint(equalToConstant: 140).isActive = true
            imageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
            imageView.backgroundColor = .blue
            return imageView
        }()
        
        private let titleMovie: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textAlignment = .left
            label.setContentHuggingPriority(.defaultHigh, for: .vertical)
            label.text = "titulo de peliculafnivbibifbsiufbdvusifakdsjdoiajsdiasjodisjoidjaiosjdoa"
            label.textColor = .black
            label.numberOfLines = 0
            return label
        }()
        
        private let launchMovie: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textAlignment = .left
            label.setContentHuggingPriority(.defaultHigh, for: .vertical)
            label.text = "Fecha de pelicula njsdncjndjccjndndjcjdndlnaskdladjaosjdoasjpdojasd"
            label.textColor = .black
            label.numberOfLines = 0
            return label
        }()
        
        private let titleGender: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = "generos"
            label.textColor = .black
            return label
        }()
        
        private let genders: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = "accion,comedia"
            label.textColor = .black
            return label
        }()
        
        private let descriptionMovie: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = "Descipcion"
            label.textColor = .black
            return label
        }()
        
        private let descriptions: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = "esta pelicula es muy bonita"
            label.textColor = .black
            return label
        }()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            self.setupView()
        }
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
            self.setupView()
        }
        
        private func setupView() {
            addSubview(mainImageView)
            
            mainImageView.addSubview(StackHorizontal)
            StackHorizontal.addArrangedSubview(innerImageView)
            StackHorizontal.addArrangedSubview(StackVertical)
            StackVertical.addArrangedSubview(titleMovie)
            StackVertical.addArrangedSubview(launchMovie)
            addSubview(titleGender)
            addSubview(genders)
            addSubview(descriptionMovie)
            addSubview(descriptions)
            
            NSLayoutConstraint.activate([
                mainImageView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
                mainImageView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
                mainImageView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
                mainImageView.widthAnchor.constraint(equalToConstant: 400),
                mainImageView.heightAnchor.constraint(equalToConstant: 200),

                StackHorizontal.leadingAnchor.constraint(equalTo: mainImageView.leadingAnchor,constant: 15),
                StackHorizontal.trailingAnchor.constraint(equalTo: mainImageView.trailingAnchor),
                StackHorizontal.topAnchor.constraint(equalTo: mainImageView.topAnchor,constant: 10),
                StackHorizontal.bottomAnchor.constraint(equalTo: mainImageView.bottomAnchor, constant: -10),
                titleMovie.topAnchor.constraint(equalTo: StackVertical.topAnchor,constant: 30),
                launchMovie.bottomAnchor.constraint(equalTo: titleMovie.topAnchor),
                
                titleGender.topAnchor.constraint(equalTo: mainImageView.bottomAnchor, constant: 30),
                titleGender.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),

                genders.topAnchor.constraint(equalTo: titleGender.bottomAnchor, constant: 10),
                genders.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),

                descriptionMovie.topAnchor.constraint(equalTo: genders.bottomAnchor, constant: 45),
                descriptionMovie.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),

                descriptions.topAnchor.constraint(equalTo: descriptionMovie.bottomAnchor, constant: 10),
                descriptions.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            ])
        }
}
