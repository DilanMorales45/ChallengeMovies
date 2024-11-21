//
//  DetailsViewController.swift
//  ChallengeMovies
//
//  Created by Dilan Alejandro Morales Estupinan on 20/11/24.
//

import UIKit

class DetailsViewController: UIViewController {
    private let detailsView: DetailsView
    private let navigationStyle: NavigationBarStyle
    
    init(detailsView: DetailsView, navigationStyle: NavigationBarStyle) {
        self.detailsView = detailsView
        self.navigationStyle = navigationStyle
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationStyle.configure(self)
    }
    private func configure() {
        self.view = detailsView
        self.detailsView.backgroundColor = .white
        self.detailsView.delegate = self
    }
}

extension DetailsViewController{
    class func build() -> DetailsViewController {
        let view = DetailsView()
        let controller = DetailsViewController( detailsView: view, navigationStyle: NavigationBarSimpleShow())
        return controller
    }
}

extension DetailsViewController: DetailsViewDelegate {
    func detailsView (_ view: DetailsView, didHitWith: String?) {
        print("Accion como poner favoritos en la navbar")
    }
}
