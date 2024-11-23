//
//  TadBar.swift
//  ChallengeMovies
//
//  Created by Mario Alfonso Orozco Pacheco on 10/11/24.
//

import UIKit

class TabBar: UITabBarController {

    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTabs()
        self.configureTabBarAppearance()
    }
    
    private func configureTabBarAppearance() {
        tabBar.backgroundColor = .white
        tabBar.tintColor = .systemBlue
        tabBar.unselectedItemTintColor = .gray
    }
    
    private func setupTabs() {
//        Controllers que se vana utilizar 
        let movieVC = MoviesViewController.build()
        let favoriteVC = FavoritesViewController.build()
        
        movieVC.tabBarItem = UITabBarItem(title: "Peliculas",
                                            image: UIImage(systemName: "square.grid.2x2"),
                                            selectedImage: UIImage(systemName: "square.grid.2x2.fill"))
        
        favoriteVC.tabBarItem = UITabBarItem(title: "Favoritos",
                                              image: UIImage(systemName: "star"),
                                              selectedImage: UIImage(systemName: "star.fill"))

        setViewControllers([movieVC, favoriteVC], animated: true)
    }
    
}

extension TabBar {
    class func build() -> TabBar {
        let controller = TabBar()
        return controller
    }
}