//
//  SearchBarRealaseDate.swift
//  ChallengeMovies
//
//  Created by Dilan Alejandro Morales Estupinan on 13/12/24.
//

import UIKit

class SearchBarRealaseDate: NSObject, SearchBarAdapter {
    var datasource: [commonDetails] = []
    
    var didFilterItem: DidFilterItem?
    
    func setSearchBar(_ searchBar: UISearchBar) {
        searchBar.delegate = self
    }
}

extension SearchBarRealaseDate: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.isEmpty {
            self.didFilterItem?(self.datasource)
        } else {
            var result: [Any] = self.datasource.filter({ $0.releaseDateShortFormat.localizedCaseInsensitiveContains(searchText) })
            result = !result.isEmpty ? result : ["No se encontraron resultados para tu busqueda:\n\n\(searchText)"]
            self.didFilterItem?(result)
        }
    }
}
