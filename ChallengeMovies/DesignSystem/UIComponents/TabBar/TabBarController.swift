//
//  TadBar.swift
//  ChallengeMovies
//
//  Created by Mario Alfonso Orozco Pacheco on 10/11/24.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
        configureTabBarAppearance()
    }
    
    private func setupTabs() {
//        Controllers que se vana utilizar 
//        let movieVC = MoviesController()
//        let favoriteVC = FavoritesController()
        
        let movieNav = createNavController(title: "Peliculas",
                                            image: UIImage(systemName: "square.grid.2x2"),
                                            selectedImage: UIImage(systemName: "square.grid.2x2.fill"),
                                            rootViewController: movieVC)
        
        let favoriteNav = createNavController(title: "Favoritos",
                                              image: UIImage(systemName: "star"),
                                              selectedImage: UIImage(systemName: "star.fill"),
                                              rootViewController: favoriteVC)

        setViewControllers([movieNav, favoriteNav], animated: true)
    }
    
    private func configureTabBarAppearance() {
        tabBar.backgroundColor = .white
        tabBar.tintColor = .systemBlue
        tabBar.unselectedItemTintColor = .gray
    }
    
    
    private func createNavController(title: String,
                                      image: UIImage?,
                                      selectedImage: UIImage?,
                                      rootViewController: UIViewController) -> UINavigationController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        navController.tabBarItem.selectedImage = selectedImage
        
        return navController
    }
}
