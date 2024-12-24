//
//  DetailsViewFavoriteController.swift
//  ChallengeMovies
//
//  Created by Mario Alfonso Orozco Pacheco on 23/12/24.
//

import UIKit

class DetailsViewFavoriteController: UIViewController {
    
    private let detailView: DetailsView
    private let navigationStyle: NavigationBarStyle
    private let movie: details
    private let favoriteService: FavoriteMovieService
    
    init(detailView: DetailsView, movie: details, navigationStyle: NavigationBarStyle, favoriteService: FavoriteMovieService) {
        self.detailView = detailView
        self.movie = movie
        self.navigationStyle = navigationStyle
        self.favoriteService = favoriteService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder: has not been implemented)")
    }
    
    deinit {
        NotificationManager.removeObserver()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationStyle.configure(self)
        self.setDetailsFavorite()
    }
    
    private func configureView() {
        self.view = self.detailView
        self.refreshLanguageTitles()
    }
    
    private func setDetailsFavorite() {
        self.detailView.updateWith(movie)
    }
    
    private func noticationLanguage() {
        NotificationManager.addObserver(selector: #selector(languageDidChange))
    }
    
    private func refreshLanguageTitles() {
        self.detailView.updateTitlesLanguage("DetailsViewController.languageDidChange.dateTitle".localized, "DetailsViewController.languageDidChange.genderTitle".localized, "DetailsViewController.languageDidChange.descriptionTitle".localized, "DetailsViewController.languageDidChange.descriptionText".localized)
    }
    
    @objc func languageDidChange() {
        self.refreshLanguageTitles()
    }
    
    private static func setImageStar(for movie: details, with favoriteService: FavoriteMovieService) -> String {
        if favoriteService.get(byIdentifier: Int64(movie.id)) != nil {
            return "star.fill"
        } else {
            return "star"
        }
    }
}

extension DetailsViewFavoriteController {
    class func buildWith(_ movie: details) -> DetailsViewFavoriteController {
        let favoriteService = FavoriteMovieService(repository: FavoriteMoviesDataRepository())
        let navStyle = NavigationBarSimpleShow(
              title: "DetailsViewController.buildWith.detailTitle".localized,
              image: setImageStar(for: movie, with: FavoriteMovieService(repository: FavoriteMoviesDataRepository())), idMovie: movie.id, favoriteService: favoriteService
          )
        let view = DetailsView()
        let controller = DetailsViewFavoriteController(detailView: view, movie: movie, navigationStyle: navStyle, favoriteService: FavoriteMovieService(repository: FavoriteMoviesDataRepository()))
        return controller
    }
}
