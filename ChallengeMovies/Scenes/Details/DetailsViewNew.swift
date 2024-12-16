//
//  DetailsViewNew.swift
//  ChallengeMovies
//
//  Created by Mario Alfonso Orozco Pacheco on 15/12/24.
//

import UIKit

class DetailsViewNew: UIView {
    
    private lazy var mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .lightGray
        return imageView
    }()
    
    private lazy var innerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .center
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: 140).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        imageView.backgroundColor = .blue
        return imageView
    }()
    
    private lazy var titleMovie: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        label.text = "titulo de peliculafnivbibifbsiufbdvusifakdsjdoiajsdiasjodisjoidjaiosjdoa"
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var launchMovie: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        label.text = "Fecha de pelicula njsdncjndjccjndndjcjdndlnaskdladjaosjdoasjpdojasd"
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var titleGender: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "generos"
        label.textColor = .black
        return label
    }()
    
    private lazy var genders: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "accion,comedia"
        label.textColor = .black
        return label
    }()
    
    private lazy var descriptionMovie: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Descipcion"
        label.textColor = .black
        return label
    }()
    
    private lazy var descriptions: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "esta pelicula es muy bonita"
        label.textColor = .black
        return label
    }()
    
    private lazy var stkContentImage = HorizontalStack(subViews: [self.innerImageView, self.stkContentTitleInfo], spacing: 8)
    
    private lazy var stkContentTitleInfo = VerticalStack(subViews: [self.titleMovie, self.launchMovie], spacing: 2)
    
    init() {
        super.init(frame: .zero)
        self.addElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addElements() {
        self.backgroundColor = .white
        self.addSubview(self.mainImageView)
        
        self.mainImageView.addSubview(self.stkContentImage)
        
        NSLayoutConstraint.activate([
            self.mainImageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            self.mainImageView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            self.mainImageView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            self.mainImageView.widthAnchor.constraint(equalToConstant: 400),
            self.mainImageView.heightAnchor.constraint(equalToConstant: 200),
        ])
    }
    
    func updateWith(_ movie: commonDetails) {
        
    }
}
