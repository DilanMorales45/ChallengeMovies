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

class SearchBarView: UIView, UISearchBarDelegate {
    
    // MARK: - Properties
    weak var delegate: SearchBarViewDelegate?
    
    private let searchBar = UISearchBar()
    
    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.refreshSearchBarLanguage()
        self.configureSearchController()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NotificationManager.removeObserver()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        delegate?.didUpdateSearchResults(searchText: searchText)
    }
        
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        delegate?.didUpdateSearchResults(searchText: "")
    }
    
    private func noticationLanguage() {
        NotificationManager.addObserver(selector: #selector(languageDidChange))
    }
    
    // MARK: - SearchBar Configuration Methods
    private func configureSearchController() {

        searchBar.delegate = self
        searchBar.showsCancelButton = false
                
        addSubview(searchBar)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
                
        NSLayoutConstraint.activate([
            searchBar.leadingAnchor.constraint(equalTo: leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: trailingAnchor),
            searchBar.topAnchor.constraint(equalTo: topAnchor),
            searchBar.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
    }
    
    private func refreshSearchBarLanguage() {
        searchBar.placeholder = "SearchBarView.refreshSearchBarLanguage.SearchPlaceholder".localized
    }
    
    @objc func languageDidChange() {
        self.refreshSearchBarLanguage()
    }
}

