//
//  SearchBarTitleAdapter.swift
//  ChallengeMovies
//
//  Created by Dilan Alejandro Morales Estupinan on 13/12/24.
//

import UIKit

class SearchBarTitleAdapter: NSObject, SearchBarAdapter {
    var datasourceMovie: [commonDetails] = []
    
    var datasourceFavorite: [details] = []
    
    var didFilterItem: DidFilterItem?
    
    func setSearchBar(_ searchBar: UISearchBar) {
        searchBar.delegate = self
    }
}

extension SearchBarTitleAdapter: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.isEmpty {
            self.didFilterItem?(self.datasourceMovie)
        } else {
            var result: [Any] = self.datasourceMovie.filter({ $0.info.localizedCaseInsensitiveContains(searchText) })
            result = !result.isEmpty ? result : ["No se encontraron resultados para tu busqueda:\n\n\(searchText)"]
            self.didFilterItem?(result)
        }
    }
}
