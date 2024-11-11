//
//  SearchBarViewController.swift
//  ChallengeMovies
//
//  Created by Mario Alfonso Orozco Pacheco on 4/11/24.
//

import UIKit

//class SearchBarViewController: UIViewController, UISearchResultsUpdating, UITableViewDataSource, UITableViewDelegate {
//    
//    var data = ["Manzana", "Banana", "Cereza", "Durazno", "Frambuesa", "Uva", "Kiwi"]
//    var filteredData: [String] = []
//    
//    let tableView = UITableView()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        // Establecer un color de fondo para asegurarnos de que la vista es visible
//        view.backgroundColor = .white
//        
//        // Inicializar la table view
//        tableView.dataSource = self
//        tableView.delegate = self
//        tableView.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(tableView)
//        
//        // Configurar las restricciones de la table view
//        NSLayoutConstraint.activate([
//            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
//        ])
//        
//        // Inicializar filteredData con todos los elementos al inicio
//        filteredData = data
//        
//        // Configurar el SearchController y agregarlo al NavigationBar
//        let searchController = UISearchController(searchResultsController: nil)
//        searchController.searchResultsUpdater = self
//        searchController.obscuresBackgroundDuringPresentation = false // Mostrar el contenido detrás de la barra de búsqueda
//        searchController.searchBar.placeholder = "Buscar frutas"
//        
//        // Agregar el SearchController a la barra de navegación
//        navigationItem.searchController = searchController
//        definesPresentationContext = true // Asegura que el SearchController no sea mostrado en otras vistas
//        
//        // Establecer el título de la vista
//        title = "Frutas"
//    }
//    
//    // MARK: - UISearchResultsUpdating
//    
//    func updateSearchResults(for searchController: UISearchController) {
//        guard let searchText = searchController.searchBar.text else { return }
//        
//        // Filtrar los datos según el texto de búsqueda
//        if searchText.isEmpty {
//            filteredData = data
//        } else {
//            filteredData = data.filter { $0.lowercased().contains(searchText.lowercased()) }
//        }
//        
//        // Recargar los datos en la tabla para mostrar los resultados filtrados
//        tableView.reloadData()
//    }
//    
//    // MARK: - UITableViewDataSource
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return filteredData.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell(style: .default, reuseIdentifier: "cell")
//        cell.textLabel?.text = filteredData[indexPath.row]
//        return cell
//    }
//}


class SearchBarViewController: UIViewController, UISearchResultsUpdating {

    var data = ["Manzana", "Banana", "Cereza", "Durazno", "Frambuesa", "Uva", "Kiwi"]
    var filteredData: [String] = []
    
    // Un simple UILabel para mostrar el resultado de la búsqueda
    let resultLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Establecer un color de fondo para asegurarnos de que la vista es visible
        view.backgroundColor = .white

        // Inicializar el UILabel
        resultLabel.translatesAutoresizingMaskIntoConstraints = false
        resultLabel.numberOfLines = 0
        resultLabel.textAlignment = .center
        view.addSubview(resultLabel)

        // Configurar las restricciones para el UILabel
        NSLayoutConstraint.activate([
            resultLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            resultLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            resultLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            resultLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])

        // Configurar el SearchController
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Buscar frutas"

        navigationItem.searchController = searchController
        definesPresentationContext = true

        title = "Frutas"

        // Inicializamos filteredData con todos los elementos al principio
        filteredData = data
    }

    // MARK: - UISearchResultsUpdating
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }

        // Filtrar los datos según el texto de búsqueda
        if searchText.isEmpty {
            filteredData = data
        } else {
            filteredData = data.filter { $0.lowercased().contains(searchText.lowercased()) }
        }
        
        // Mostrar los resultados de la búsqueda en el UILabel
        resultLabel.text = filteredData.joined(separator: "\n")
    }
}
