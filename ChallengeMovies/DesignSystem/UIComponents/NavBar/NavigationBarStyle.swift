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
    private let image: String
    private var viewController: UIViewController?
    private let idMovie: Int
    private let favoriteService: FavoriteMovieService
    
    
    init(title: String, image: String, idMovie: Int, favoriteService: FavoriteMovieService) {
        self.title = title
        self.image = image
        self.idMovie = idMovie
        self.favoriteService = favoriteService
    }
    
    func configure(_ viewController: UIViewController) {
        self.viewController = viewController
        viewController.navigationController?.isNavigationBarHidden = false
        viewController.title = self.title
        viewController.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: self.image), style: .plain, target: self, action: #selector(self.addToFavorites))
        viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(self.back))
        viewController.navigationController?.navigationBar.tintColor = .textWhite
        viewController.navigationItem.rightBarButtonItem?.tintColor = .systemOrange
    }
    
    @objc private func back() {
        self.viewController?.navigationController?.popViewController(animated: true)
    }
    
    
    @objc func addToFavorites() {
        if let favoriteMovie = self.favoriteService.get(byIdentifier: Int64(idMovie)) {
            // La película ya está en favoritos, puedes mostrar un mensaje o realizar alguna acción.
            let validation = self.favoriteService.delete(record: favoriteMovie)
            print(validation)
            print("ya no esta en favoritos")
        } else {
            self.favoriteService.create(favoriteMovie: FavoriteMovie(idMovie: Int64(idMovie), favorite: true, id: UUID()))
            let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            debugPrint(path[0])
            print("pelicula guardada en favoritos")
            
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

