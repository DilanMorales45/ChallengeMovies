//
//  MoviesView.swift
//  ChallengeMovies
//
//  Created by Mario Alfonso Orozco Pacheco on 8/11/24.
//

import UIKit
import SwiftUI

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
    private var listAdapter: ListAdapter
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.text = "tintos"
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    // MARK: - Initializer
    init(listAdapter: ListAdapter) {
        self.listAdapter = listAdapter
        super.init(frame: .zero)
        self.setupViews()
        self.configureAdapters()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Method
    private func setupViews() {
        self.backgroundColor = .white
        self.addSubview(searchBarView)
        self.addSubview(collectionView)
        NSLayoutConstraint.activate([
            self.searchBarView.topAnchor.constraint(equalTo: self.topAnchor),
            self.searchBarView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.searchBarView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.searchBarView.bottomAnchor.constraint(equalTo: self.collectionView.topAnchor),
            self.collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    private func configureAdapters() {
        self.listAdapter.setCollectionView(self.collectionView)
    }
    
    // MARK: - Setup Method
    func reloadCollectionView(_ datasource: [commonDetails]) {
        self.listAdapter.datasource = datasource
        self.collectionView.reloadData()
    }
    
    // MARK: - Set Title
    func setTitle(_ title: String) {
        titleLabel.text = title
    }
}

struct MoviesViewRepresentable: UIViewRepresentable {
    func makeUIView(context: Context) -> MoviesView{
        let movies = [commonDetails.mock, commonDetails.mock, commonDetails.mock, commonDetails.mock]
        let listAdapter = MoviesSimpleListAdapter()
        let view = MoviesView(listAdapter: listAdapter)
        view.reloadCollectionView(movies)
        return view
    }
    
    func updateUIView(_ uiView: MoviesView, context: Context) { }
}

#Preview {
    MoviesViewRepresentable()
}
