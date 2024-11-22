//
//  TadBar.swift
//  ChallengeMovies
//
//  Created by Mario Alfonso Orozco Pacheco on 10/11/24.
//

import UIKit

class TabBarView: UIView {
    private let tabBar = UITabBar()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureTabBar()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func configureTabBar() {
        self.tabBar.backgroundColor = .white
        self.tabBar.tintColor = .systemBlue
        self.tabBar.unselectedItemTintColor = .gray
    }
}

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
    }
    
    private func setupTabs() {
//        Controllers que se vana utilizar 
        let movieVC = MoviesViewController.build()
        let favoriteVC = FavoritesViewController.build()
        
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

