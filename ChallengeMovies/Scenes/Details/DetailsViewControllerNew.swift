//
//  DetailsViewControllerNew.swift
//  ChallengeMovies
//
//  Created by Mario Alfonso Orozco Pacheco on 15/12/24.
//

import UIKit

class DetailsViewControllerNew: UIViewController {
    
    private let detailView: DetailsViewNew
    private let navigationStyle: NavigationBarStyle
    private let movie: commonDetails
    
    init(detailView: DetailsViewNew, movie: commonDetails, navigationStyle: NavigationBarStyle) {
        self.detailView = detailView
        self.movie = movie
        self.navigationStyle = navigationStyle
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder: has not been implemented)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationStyle.configure(self)
    }
    
    private func configureView() {
        self.view = self.detailView
        self.detailView.updateWith(self.movie)
    }
}

extension DetailsViewControllerNew {
    class func buildWith(_ movie: commonDetails) -> DetailsViewControllerNew {
        let navStyle =  NavigationBarTitle(title: "Detalles")
        let view = DetailsViewNew()
        let controller = DetailsViewControllerNew(detailView: view, movie: movie, navigationStyle: navStyle)
        return controller
    }
}
