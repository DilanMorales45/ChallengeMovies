//
//  MoviesViewController.swift
//  ChallengeMovies
//
//  Created by Mario Alfonso Orozco Pacheco on 11/11/24.
//

import UIKit

class MoviesViewController: UIViewController, SearchBarViewDelegate, UICollectionViewDataSource {
    
    // MARK: - Properties
    var data = house
    var filteredData: [Device] = []
    private var moviesView: MoviesView!

    
    // MARK: - Lifecycle Methods
    override func loadView() {
        
        moviesView = MoviesView()
        moviesView.searchBarView.delegate = self
        moviesView.collectionView.dataSource = self
        moviesView.collectionView.delegate = self
        self.view = moviesView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        moviesView.collectionView.register(MoviesCollectionViewCell.self, forCellWithReuseIdentifier: "MoviesCollectionViewCell")
        
        filteredData = data
    }
    
    // MARK: - SearchBarViewDelegate
    
    func didUpdateSearchResults(searchText: String) {
        
        if searchText.isEmpty {
            filteredData = data
        } else {
            filteredData = data.filter { $0.title.lowercased().contains(searchText.lowercased()) }
        }
        
        moviesView.reloadCollectionView()
    }
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoviesCollectionViewCell", for: indexPath) as! MoviesCollectionViewCell
        
        
        let model = filteredData[indexPath.row]
        
        
        cell.configure(model: model)
        
        
        cell.backgroundColor = .white
        cell.layer.cornerRadius = 20
        cell.layer.masksToBounds = false
        cell.layer.shadowColor = UIColor.gray.cgColor
        cell.layer.shadowOpacity = 0.4
        cell.layer.shadowOffset = CGSize(width: 0, height: 0)
        cell.layer.shadowRadius = 5
        
        return cell
    }

}

// MARK: - UICollectionViewDelegate
extension MoviesViewController: UICollectionViewDelegate {
    
}
