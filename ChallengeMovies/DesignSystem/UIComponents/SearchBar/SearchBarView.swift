//
//  SearchBarViewController.swift
//  ChallengeMovies
//
//  Created by Mario Alfonso Orozco Pacheco on 4/11/24.
//

import UIKit

// MARK: - Component for SearchBar
protocol SearchBarViewDelegate: AnyObject {
    func didUpdateSearchResults(searchText: String)
}

class SearchBarView: UIView, UISearchResultsUpdating {
    
    // MARK: - Properties
    weak var delegate: SearchBarViewDelegate?
    
    private let searchController: UISearchController
    
    // MARK: - Initializer
    override init(frame: CGRect) {
        searchController = UISearchController(searchResultsController: nil)
        super.init(frame: frame)
        configureSearchController()
    }
    
    required init?(coder: NSCoder) {
        searchController = UISearchController(searchResultsController: nil)
        super.init(coder: coder)
        configureSearchController()
    }
    
    // MARK: - SearchBar Configuration Methods
    private func configureSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Buscar dispositivos"
        searchController.title = "Cinemark"
        
        
        addSubview(searchController.searchBar)
        searchController.searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            searchController.searchBar.leadingAnchor.constraint(equalTo: leadingAnchor),
            searchController.searchBar.trailingAnchor.constraint(equalTo: trailingAnchor),
            searchController.searchBar.topAnchor.constraint(equalTo: topAnchor),
            searchController.searchBar.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    // MARK: - UISearchResultsUpdating
    
    func updateSearchResults(for searchController: UISearchController) {
        
        delegate?.didUpdateSearchResults(searchText: searchController.searchBar.text ?? "")
    }
}

