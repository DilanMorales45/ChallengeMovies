//
//  MoviesView.swift
//  ChallengeMovies
//
//  Created by Mario Alfonso Orozco Pacheco on 8/11/24.
//

import UIKit

struct Device {
    let title: String
    let imageName: String
}

let house = [
    Device(title: "Laptop", imageName: "laptopcomputer"),
    Device(title: "Mac mini", imageName: "macmini"),
    Device(title: "Mac Pro", imageName: "macpro.gen3"),
    Device(title: "Pantallas", imageName: "display.2"),
    Device(title: "Apple TV", imageName: "appletv")
]


class MoviesView: UIView {
    
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
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = .init(width: 380, height: 190)
        layout.minimumLineSpacing = 20
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupViews()
    }
    
    // MARK: - Setup Method
    private func setupViews() {
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
