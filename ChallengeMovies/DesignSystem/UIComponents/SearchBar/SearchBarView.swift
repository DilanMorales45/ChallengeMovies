//
//  SearchBarViewController.swift
//  ChallengeMovies
//
//  Created by Mario Alfonso Orozco Pacheco on 4/11/24.
//

import UIKit

// 1. Componente para la barra de búsqueda
protocol SearchBarViewDelegate: AnyObject {
    func didUpdateSearchResults(searchText: String)
}

class SearchBarView: UIView, UISearchResultsUpdating {
    
    // 2. Propiedades
    weak var delegate: SearchBarViewDelegate?
    
    private let searchController: UISearchController
    
    // 3. Inicializador
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
    
    // 4. Configuración de la barra de búsqueda
    private func configureSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Buscar dispositivos"
        
        // Agregar la search bar a la vista
        addSubview(searchController.searchBar)
        searchController.searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        // Configuración de las restricciones
        NSLayoutConstraint.activate([
            searchController.searchBar.leadingAnchor.constraint(equalTo: leadingAnchor),
            searchController.searchBar.trailingAnchor.constraint(equalTo: trailingAnchor),
            searchController.searchBar.topAnchor.constraint(equalTo: topAnchor),
            searchController.searchBar.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    // MARK: - UISearchResultsUpdating
    
    func updateSearchResults(for searchController: UISearchController) {
        // Llamar al delegado cuando se actualicen los resultados
        delegate?.didUpdateSearchResults(searchText: searchController.searchBar.text ?? "")
    }
}

