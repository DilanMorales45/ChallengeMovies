//
//  MoviesViewController.swift
//  ChallengeMovies
//
//  Created by Mario Alfonso Orozco Pacheco on 11/11/24.
//

import UIKit

class MoviesViewController: UIViewController, SearchBarViewDelegate, UICollectionViewDataSource {
    
    // MARK: - Properties
    var data = house
    var filteredData: [Device] = []
    private let moviesView: MoviesView
    private let navigationStyle: NavigationBarStyle

    init(moviesView: MoviesView, navigationStyle: NavigationBarStyle) {
        self.moviesView = moviesView
        self.navigationStyle = navigationStyle
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle Methods
    
    override func loadView() {
        self.configureView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.moviesView.setTitle("Cinemark")
        self.moviesView.collectionView.register(MoviesCollectionViewCell.self, forCellWithReuseIdentifier: "MoviesCollectionViewCell")
        
        self.filteredData = data
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationStyle.configure(self)
    }
    
    private func configureView() {
        self.view = moviesView
        self.moviesView.searchBarView.delegate = self
        self.moviesView.collectionView.dataSource = self
        self.moviesView.collectionView.delegate = self
    }
    
    // MARK: - SearchBarViewDelegate
    
    func didUpdateSearchResults(searchText: String) {
        
        if searchText.isEmpty {
            filteredData = data
        } else {
            filteredData = data.filter { $0.title.lowercased().contains(searchText.lowercased()) }
        }
        
        moviesView.reloadCollectionView()
    }
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoviesCollectionViewCell", for: indexPath) as! MoviesCollectionViewCell
        
        
        let model = filteredData[indexPath.row]
        
        
        cell.configure(model: model)
        
        
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

// MARK: - Build Extension for MoviesViewController
extension MoviesViewController {
    class func build() -> MoviesViewController {
        let view = MoviesView()
        let controller = MoviesViewController(moviesView: view, navigationStyle: NavigationBarHide())
        controller.title = "Cinemark"
        return controller
    }
}

// MARK: - UICollectionViewDelegate
extension MoviesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Llama a la función openDetails() o navega directamente a la pantalla de detalles
        openDetails()
    }
    
    func openDetails (){
        let jumpToController = DetailsViewController.build()
//        jumpToController.title =  // Configura el controller con la información del movie

        self.navigationController?.pushViewController(jumpToController, animated: true)
    }
}
