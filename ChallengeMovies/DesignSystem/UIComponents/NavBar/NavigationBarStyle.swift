//
//  NavigationBarStyle.swift
//  ChallengeMovies
//
//  Created by Dilan Alejandro Morales Estupinan on 20/11/24.
//

import UIKit

protocol NavigationBarStyle {
    
    func configure (_ viewController: UIViewController)
    
}

struct NavigationBarHide: NavigationBarStyle {
    func configure(_ viewController: UIViewController) {
        viewController.navigationController?.isNavigationBarHidden = true
        viewController.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
}

class NavigationBarSimpleShow: NavigationBarStyle {
    private let title: String
    private var image: String
    private var viewController: UIViewController?
    private let idMovie: Int
    private let favoriteService: FavoriteMovieService
    private var isFavorite: Bool
    
    init(title: String, image: String, idMovie: Int, favoriteService: FavoriteMovieService) {
        self.title = title
        self.image = image
        self.idMovie = idMovie
        self.favoriteService = favoriteService
        self.isFavorite = favoriteService.get(byIdentifier: Int64(idMovie)) != nil
    }
    
    func configure(_ viewController: UIViewController) {
        self.viewController = viewController
        viewController.navigationController?.isNavigationBarHidden = false
        viewController.title = self.title
        self.updateFavoriteButton()
        viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(self.back))
        viewController.navigationController?.navigationBar.tintColor = .textWhite
        
        let rightButton = UIBarButtonItem(image: UIImage(systemName: self.image), style: .plain, target: self, action: #selector(self.addToFavorites))
        viewController.navigationItem.rightBarButtonItem = rightButton
        viewController.navigationItem.rightBarButtonItem?.tintColor = .systemOrange
    }
    
    @objc private func back() {
        self.viewController?.navigationController?.popViewController(animated: true)
    }
    
    @objc private func addToFavorites() {
        if let favoriteMovie = self.favoriteService.get(byIdentifier: Int64(idMovie)) {
            let validation = self.favoriteService.delete(record: favoriteMovie)
            print(validation)
            print("ya no esta en favoritos")
            isFavorite = false
        } else {
            self.favoriteService.create(favoriteMovie: FavoriteMovie(idMovie: Int64(idMovie), favorite: true, id: UUID()))
            let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            debugPrint(path[0])

            print("pelicula guardada en favoritos")
            isFavorite = true
        }
        
        self.updateFavoriteButton()
    }
    
    private func updateFavoriteButton() {
        let favoriteImageName = isFavorite ? "star.fill" : "star"
        if let rightButton = viewController?.navigationItem.rightBarButtonItem {
            rightButton.image = UIImage(systemName: favoriteImageName)
        }
    }
}

struct NavigationBarTitle: NavigationBarStyle {
    private let title: String
    init(title: String) {
        self.title = title
    }
    func configure(_ viewController: UIViewController) {
        viewController.title = self.title
        viewController.navigationController?.isNavigationBarHidden = false
        viewController.navigationItem.hidesBackButton = false
        viewController.navigationController?.navigationBar.tintColor = UIColor(named: "text_white")
    }
}

