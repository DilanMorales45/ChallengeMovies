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

// Deleted: UISearchResultsUpdating
class SearchBarView: UIView, UISearchBarDelegate {
    
    // MARK: - Properties
    weak var delegate: SearchBarViewDelegate?
    
//    private let searchController = UISearchController(searchResultsController: nil)
    private let searchBar = UISearchBar()
    
    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureSearchController()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureSearchController()
    }
    
    // MARK: - SearchBar Configuration Methods
    private func configureSearchController() {
//        backgroundColor = .cyan
        
//        searchController.searchResultsUpdater = self
//        searchController.obscuresBackgroundDuringPresentation = false
//        searchController.hidesNavigationBarDuringPresentation = false
//        searchController.searchBar.placeholder = "Buscar dispositivos"
//        searchController.title = "Cinemark"
//        
//        addSubview(searchController.searchBar)
//        searchController.searchBar.translatesAutoresizingMaskIntoConstraints = false
//        
//        
//        NSLayoutConstraint.activate([
//            searchController.searchBar.leadingAnchor.constraint(equalTo: leadingAnchor),
//            searchController.searchBar.trailingAnchor.constraint(equalTo: trailingAnchor),
//            searchController.searchBar.topAnchor.constraint(equalTo: topAnchor),
//            searchController.searchBar.bottomAnchor.constraint(equalTo: bottomAnchor)
//        ])
        
        searchBar.delegate = self
        searchBar.placeholder = "Buscar dispositivos"
        searchBar.showsCancelButton = true
                
        addSubview(searchBar)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
                
        NSLayoutConstraint.activate([
            searchBar.leadingAnchor.constraint(equalTo: leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: trailingAnchor),
            searchBar.topAnchor.constraint(equalTo: topAnchor),
            searchBar.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
    }
    
    // MARK: - UISearchResultsUpdating
    
//    func updateSearchResults(for searchController: UISearchController) {
//        
//        delegate?.didUpdateSearchResults(searchText: searchController.searchBar.text ?? "")
//    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        delegate?.didUpdateSearchResults(searchText: searchText)
    }
        
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        delegate?.didUpdateSearchResults(searchText: "")
    }
}

