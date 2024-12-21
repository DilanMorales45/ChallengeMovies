//
//  DetailsViewController.swift
//  ChallengeMovies
//
//  Created by Mario Alfonso Orozco Pacheco on 15/12/24.
//

import UIKit

class DetailsViewController: UIViewController {
    
    private let detailView: DetailsView
    private let navigationStyle: NavigationBarStyle
    private let service: MoviesDetailWebService
    private let movie: commonDetails
    private let favoriteService: FavoriteMovieService
    
    init(detailView: DetailsView, movie: commonDetails, navigationStyle: NavigationBarStyle, service: MoviesDetailWebService, favoriteService: FavoriteMovieService) {
        self.detailView = detailView
        self.movie = movie
        self.navigationStyle = navigationStyle
        self.service = service
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
        self.fetch()
    }
    
    private func configureView() {
        self.view = self.detailView
        self.refreshLanguageTitles()
    }
    
    private func fetch() {
        self.service.fetch { detailDTO in
            guard let dto = detailDTO.first else { return }
            let detailsObject = details(dto: dto)
            self.detailView.updateWith(detailsObject)
        }
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
    
    private static func setImageStar(for movie: commonDetails, with favoriteService: FavoriteMovieService) -> String {
        if favoriteService.get(byIdentifier: Int64(movie.id)) != nil {
            return "star.fill"
        } else {
            return "star"
        }
    }
}

extension DetailsViewController {
    class func buildWith(_ movie: commonDetails) -> DetailsViewController {
        let favoriteService = FavoriteMovieService(repository: FavoriteMoviesDataRepository())
        let navStyle = NavigationBarSimpleShow(
              title: "DetailsViewController.buildWith.detailTitle".localized,
              image: setImageStar(for: movie, with: FavoriteMovieService(repository: FavoriteMoviesDataRepository())), idMovie: movie.id, favoriteService: favoriteService
          )
        let service = MoviesDetailWebService(idMovie: String(movie.id), language: LocalizationManager.shared.get())
        let view = DetailsView()
        let controller = DetailsViewController(detailView: view, movie: movie, navigationStyle: navStyle, service: service, favoriteService: FavoriteMovieService(repository: FavoriteMoviesDataRepository()))
        return controller
    }
}
