//
//  MoviesView.swift
//  ChallengeMovies
//
//  Created by Mario Alfonso Orozco Pacheco on 8/11/24.
//

import UIKit

struct Device {
    let title: String
    let imageName: String
}

let house = [
    Device(title: "Laptop", imageName: "laptopcomputer"),
    Device(title: "Mac mini", imageName: "macmini"),
    Device(title: "Mac Pro", imageName: "macpro.gen3"),
    Device(title: "Pantallas", imageName: "display.2"),
    Device(title: "Apple TV", imageName: "appletv")
]

class MoviesGeneralController: UIViewController, SearchBarViewDelegate {
    
    var data = house // Los datos iniciales que mostrarás en la colección
    var filteredData: [Device] = [] // Datos filtrados
    
    private let searchBarView = SearchBarView() // Instancia del SearchBarView
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = .init(width: 380, height: 190)
        layout.minimumLineSpacing = 20
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configurar la vista principal
        view.backgroundColor = .white
        
        // Configurar la colección
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(MoviesCollectionViewCell.self, forCellWithReuseIdentifier: "MoviesCollectionViewCell")
        view.addSubview(collectionView)
        
        // Configurar las restricciones de la colección
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: searchBarView.bottomAnchor, constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        // Agregar la vista de la barra de búsqueda en la parte superior
        searchBarView.delegate = self
        view.addSubview(searchBarView)
        
        // Configurar las restricciones de la vista de la barra de búsqueda
        searchBarView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchBarView.topAnchor.constraint(equalTo: view.topAnchor),
            searchBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchBarView.heightAnchor.constraint(equalToConstant: 60) // Ajusta la altura de la barra de búsqueda
        ])
        
        // Inicializamos filteredData con todos los elementos al principio
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
        
        // Recargar los datos en la colección para mostrar los resultados filtrados
        collectionView.reloadData()
    }
}

extension MoviesGeneralController: UICollectionViewDataSource {
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

extension MoviesGeneralController: UICollectionViewDelegate {
    // Implementa cualquier método necesario para manejar la interacción con las celdas
}
