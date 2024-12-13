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

struct NavigationBarSimpleShow: NavigationBarStyle {
    func configure(_ viewController: UIViewController) {
        viewController.navigationController?.isNavigationBarHidden = false
        viewController.navigationItem.title = "Detalle Pelicula"
        viewController.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "star"), style: .plain, target: nil, action: nil)
        viewController.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        viewController.navigationController?.navigationBar.tintColor = .black
        viewController.navigationItem.rightBarButtonItem?.tintColor = .systemYellow
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

