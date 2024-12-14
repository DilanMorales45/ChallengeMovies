//
//  SearchBarTitleAdapter.swift
//  ChallengeMovies
//
//  Created by Dilan Alejandro Morales Estupinan on 13/12/24.
//

import UIKit

class SearchBarTitleAdapter: NSObject, SearchBarAdapter {
    var datasource: [commonDetails] = []
    
    var didFilterItem: DidFilterItem?
    
    func setSearchBar(_ searchBar: UISearchBar) {
        searchBar.delegate = self
    }
}

extension SearchBarTitleAdapter: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.isEmpty {
            self.didFilterItem?(self.datasource)
        } else {
            let result = self.datasource.filter({ $0.info.localizedCaseInsensitiveContains(searchText) })
            self.didFilterItem?(result)
        }
    }
}
