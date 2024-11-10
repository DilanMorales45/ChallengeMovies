//
//  LoginViewController.swift
//  challengeMovies
//
//  Created by Dilan Alejandro Morales Estupinan on 28/10/24.
//

import UIKit

// MARK: - Constants
let LocalizeUserDefaultKey = "LocalizeUserDefaultKey"
var LocalizeDefaultLanguage = "en"

class LoginViewController: UIViewController {
    
    // MARK: - Properties
    private let loginView: LoginView
    
    init(loginView: LoginView){
        self.loginView = loginView
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
            string: "LoginViewController.refreshLanguage.EmailMessage".translate(),
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]
        )
        loginView.accessButton.setTitle("LoginViewController.refreshLanguage.AccessButton".translate(), for: .normal)
    }

    @objc private func changeLanguageSpanish() {
        LocalizeDefaultLanguage = "es-419"
        UserDefaults.standard.setValue(LocalizeDefaultLanguage, forKey: LocalizeUserDefaultKey)
        refreshLanguage()
    }

    @objc private func changeLanguageEnglish() {
        LocalizeDefaultLanguage = "en"
        UserDefaults.standard.setValue(LocalizeDefaultLanguage, forKey: LocalizeUserDefaultKey)
        refreshLanguage()
    }
    
    @objc private func doSignIn() {
        loginView.delegate?.loginView(self.loginView, didSignWith: self.loginView.emailLabel.text)
    }
    
}

// MARK: - String Extension for Localization
extension String {
    func translate() -> String {
        if let path = Bundle.main.path(forResource: LocalizeDefaultLanguage, ofType: "lproj"),
           let bundle = Bundle(path: path) {
            return NSLocalizedString(self, bundle: bundle, comment: "")
        }
        return ""
    }
}

// MARK: - Build Extension for LoginViewController
extension LoginViewController {
    class func build() -> LoginViewController {
        let view = LoginView()
        let controller = LoginViewController(loginView: view)
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
    }

}
