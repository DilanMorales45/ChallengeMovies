//
//  SearchBarAdapter.swift
//  ChallengeMovies
//
//  Created by Dilan Alejandro Morales Estupinan on 13/12/24.
//

import UIKit

protocol SearchBarAdapter: AnyObject {
    typealias DidFilterItem = (_ result: [Any]) -> Void
    var datasource: [commonDetails] { get set }
    var didFilterItem: DidFilterItem? { get set }
    func setSearchBar(_ searchBar: UISearchBar)
    
}
