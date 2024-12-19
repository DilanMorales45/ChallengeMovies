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
    private var viewController: UIViewController?
    init(title: String) {
        self.title = title
    }
    func configure(_ viewController: UIViewController) {
        self.viewController = viewController
        viewController.navigationController?.isNavigationBarHidden = false
        viewController.title = self.title
        viewController.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "star"), style: .plain, target: nil, action: nil)
        viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(self.back))
        viewController.navigationController?.navigationBar.tintColor = .textWhite
        viewController.navigationItem.rightBarButtonItem?.tintColor = .systemOrange
    }
    
    @objc private func back() {
        self.viewController?.navigationController?.popViewController(animated: true)
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

