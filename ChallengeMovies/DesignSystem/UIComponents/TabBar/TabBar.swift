//
//  TadBar.swift
//  ChallengeMovies
//
//  Created by Mario Alfonso Orozco Pacheco on 10/11/24.
//

import UIKit

class TabBar: UITabBarController {
    private var movieVCTitle: String = ""
    private var favoriteVCTitle: String = ""
    private let navigationBarStyle: NavigationBarStyle
    
    init(navigationBarStyle: NavigationBarStyle) {
        self.navigationBarStyle = navigationBarStyle
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NotificationManager.removeObserver()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureTabBarAppearance()
        self.manageNotifications()
        self.setupTabs()
        self.refreshTabBarLanguage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationBarStyle.configure(self)
    }
    
    private func configureTabBarAppearance() {
        tabBar.backgroundColor = UIColor(named: "background_dark_white")
        tabBar.tintColor = UIColor(named: "tabbar_item_selected")
        tabBar.unselectedItemTintColor = UIColor(named: "tabbar_item_deselected")
    }
    
    private func setupTabs() {
        let movieVC = MoviesViewController.buildSimpleList()
        let favoriteVC = FavoritesViewController.buildGridList()
        
        movieVC.tabBarItem = UITabBarItem(title: movieVCTitle,
                                          image: UIImage(systemName: "square.grid.2x2"),
                                          selectedImage: UIImage(systemName: "square.grid.2x2.fill"))
        
        favoriteVC.tabBarItem = UITabBarItem(title: favoriteVCTitle,
                                             image: UIImage(systemName: "star"),
                                             selectedImage: UIImage(systemName: "star.fill"))

        setViewControllers([movieVC, favoriteVC], animated: true)
    }
    
    private func manageNotifications() {
        NotificationManager.addObserver(selector: #selector(languageDidChange))
    }
    
    private func refreshTabBarLanguage() {
        movieVCTitle = "TabBar.refreshTabBarLanguage.movieTitle".localized
        favoriteVCTitle = "TabBar.refreshTabBarLanguage.favoriteTitle".localized
        self.setupTabs()
    }
    
    @objc func languageDidChange() {
        self.refreshTabBarLanguage()
    }
}

extension TabBar {
    class func build() -> TabBar {
        let navBar = NavigationBarTitle(title: "Cinemark")
        let controller = TabBar(navigationBarStyle: navBar)
        return controller
    }
}
