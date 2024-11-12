//
//  MoviesViewController.swift
//  ChallengeMovies
//
//  Created by Mario Alfonso Orozco Pacheco on 11/11/24.
//

import UIKit

// MARK: - MoviesViewController (Controlador)
class MoviesViewController: UIViewController, SearchBarViewDelegate, UICollectionViewDataSource {
    
    // MARK: - Propiedades
    var data = house // Datos originales
    var filteredData: [Device] = [] // Datos filtrados
    private var moviesView: MoviesView! // La vista personalizada

    override func loadView() {
        // Usamos la vista personalizada que contiene el layout
        moviesView = MoviesView()
        moviesView.searchBarView.delegate = self // Configurar el delegado para la búsqueda
        moviesView.collectionView.dataSource = self
        moviesView.collectionView.delegate = self
        view = moviesView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Registrar la celda personalizada con el identificador correspondiente
                moviesView.collectionView.register(MoviesCollectionViewCell.self, forCellWithReuseIdentifier: "MoviesCollectionViewCell")
        // Inicializar con todos los elementos al principio
        filteredData = data
    }
    
    // MARK: - SearchBarViewDelegate
    
    func didUpdateSearchResults(searchText: String) {
        // Filtrar los datos según el texto de búsqueda
        if searchText.isEmpty {
            filteredData = data // Mostrar todos los elementos si el campo está vacío
        } else {
            filteredData = data.filter { $0.title.lowercased().contains(searchText.lowercased()) }
        }
        
        // Recargar la colección con los resultados filtrados
        moviesView.reloadCollectionView()
    }
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoviesCollectionViewCell", for: indexPath) as! MoviesCollectionViewCell
        
        // Obtener el modelo filtrado
        let model = filteredData[indexPath.row]
        
        // Configurar la celda con el modelo
        cell.configure(model: model)
        
        // Aplicar estilos como bordes redondeados y sombra
        cell.backgroundColor = .white
        cell.layer.cornerRadius = 20
        cell.layer.masksToBounds = false
        cell.layer.shadowColor = UIColor.gray.cgColor
        cell.layer.shadowOpacity = 0.4
        cell.layer.shadowOffset = CGSize(width: 0, height: 0)
        cell.layer.shadowRadius = 5
        
        return cell
    }

}

// MARK: - UICollectionViewDelegate
extension MoviesViewController: UICollectionViewDelegate {
    // Implementa cualquier método necesario para manejar la interacción con las celdas
}
