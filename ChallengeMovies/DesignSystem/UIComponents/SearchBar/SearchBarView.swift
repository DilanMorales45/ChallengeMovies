//
//  SearchBarViewController.swift
//  ChallengeMovies
//
//  Created by Mario Alfonso Orozco Pacheco on 4/11/24.
//

import UIKit

class SearchBarView: UIView, UISearchBarDelegate {
    
    // MARK: - Properties
    let searchBar = UISearchBar()
    
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
    
    private func noticationLanguage() {
        NotificationManager.addObserver(selector: #selector(languageDidChange))
    }
    
    // MARK: - SearchBar Configuration Methods
    private func configureSearchController() {

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

