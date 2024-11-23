//
//  FavoritiesView.swift
//  ChallengeMovies
//
//  Created by Dilan Alejandro Morales Estupinan on 12/11/24.
//

import UIKit

class FavoritesView: UIView {
    
    // MARK: - UI Components
    let searchBarView = SearchBarView()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
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
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let width = (UIScreen.main.bounds.width - 40) / 2
        let height = (UIScreen.main.bounds.height - 60) / 2
        layout.itemSize = CGSize(width: width, height: height)
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 20
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
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
        backgroundColor = .white
        
        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
        
        addSubview(searchBarView)
        searchBarView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchBarView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            searchBarView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            searchBarView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            searchBarView.heightAnchor.constraint(equalToConstant: 70)
        ])
        
        addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: searchBarView.bottomAnchor, constant: 4),
            collectionView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    // MARK: - Setup Method
    func reloadCollectionView() {
        collectionView.reloadData()
    }
    
    // MARK: - Set Title
    func setTitle(_ title: String) {
        titleLabel.text = title
    }
}
