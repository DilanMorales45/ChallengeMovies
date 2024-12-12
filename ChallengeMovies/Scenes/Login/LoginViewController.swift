//
//  LoginViewController.swift
//  challengeMovies
//
//  Created by Dilan Alejandro Morales Estupinan on 28/10/24.
//

import UIKit

class LoginViewController: UIViewController {
    
    // MARK: - Properties
    private let loginView: LoginView
    private let navigationStyle: NavigationBarStyle
//    lazy var api = MoviesService()
    
    init(loginView: LoginView, navigationStyle: NavigationBarStyle){
        self.loginView = loginView
        self.navigationStyle = navigationStyle
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
        
        loginView.translateSpanishButton.addTarget(self, action: #selector(changeLanguageSpanish), for: .touchUpInside)
        loginView.translateEnglishButton.addTarget(self, action: #selector(changeLanguageEnglish), for: .touchUpInside)
        loginView.accessButton.addTarget(self, action: #selector(doSignIn), for: .touchUpInside)
        refreshLanguage()
    }
    
    // MARK: - Configure View Method
    
    private func configureView() {
        self.view = self.loginView
        self.loginView.delegate = self
        self.navigationStyle.configure(self)
        self.loginView.backgroundColor = UIColor(named: "background_dark_white")
    }
    
    // MARK: - Alert Message Method
    
    private func showErrorAlertMessage(_ message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Aceptar", style: .default) { _ in
            alertController.dismiss(animated: true)
        }
        alertController.addAction(action)
        self.present(alertController, animated: true)
    }

    // MARK: - Language Change Methods
    private func refreshLanguage() {
        loginView.emailLabel.attributedPlaceholder = NSAttributedString(
            string: "LoginViewController.refreshLanguage.EmailMessage".localized,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]
        )
        loginView.accessButton.setTitle("LoginViewController.refreshLanguage.AccessButton".localized, for: .normal)
        
        NotificationCenter.default.post(name: Notification.Name("languageDidChange"), object: nil)
    }

    @objc private func changeLanguageSpanish() {
        LocalizationManager.shared.set(language: .es)
        refreshLanguage()
    }

    @objc private func changeLanguageEnglish() {
        LocalizationManager.shared.set(language: .en)
        refreshLanguage()
    }
    
    @objc private func doSignIn() {
        loginView.delegate?.loginView(self.loginView, didSignWith: self.loginView.emailLabel.text)
    }
    
}

// MARK: - Build Extension for LoginViewController
extension LoginViewController {
    class func build() -> LoginViewController {
        let view = LoginView()
        let controller = LoginViewController(loginView: view, navigationStyle: NavigationBarHide())
        return controller
    }
}

// MARK: - Construction LoginViewDelegate to events of LoginViewController
extension LoginViewController: LoginViewDelegate {
    func loginView(_ view: LoginView, didSignWith user: String?) {
        guard let user = user, !user.isEmpty else {
            self.showErrorAlertMessage("Ingresa un correo")
            return
        }
        
        print("Bienvenido")
        
//        api.performRequest(for: .popularMovies) { movies in
//            DispatchQueue.main.async {
//                if let movies = movies {
//                    for movie in movies {
//                        print("Película: \(movie.title ?? ""), Fecha de estreno: \(movie.releaseDate ?? ""), Promedio de votos: \(movie.voteAverage ?? 0.0)")
//                    }
//                } else {
//                    print("No se pudieron cargar las películas")
//                }
//            }
//        }
        
        let TabBar = TabBar.build()
        self.navigationController?.pushViewController(TabBar, animated: true)
//        self.navigationController?.popToViewController(LoginViewController.build(), animated: true)
        self.navigationController?.viewControllers = [TabBar]
    }

}
