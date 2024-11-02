//
//  LoginViewController.swift
//  challengeMovies
//
//  Created by Dilan Alejandro Morales Estupinan on 28/10/24.
//

import UIKit

class LoginViewController: UIViewController {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "Cinemark"
        label.font = UIFont(name: "Arial Rounded MT Bold", size: 36)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let emailLabel: UITextField = {
        let text = UITextField()
        text.backgroundColor = .lightGray
        text.attributedPlaceholder = NSAttributedString(
            string: "Ingresa tu correo",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]
        )
        text.borderStyle = .roundedRect
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    private let accessButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Acceder", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(titleLabel)
        view.addSubview(emailLabel)
        view.addSubview(accessButton)
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -40),
            titleLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            emailLabel.centerXAnchor.constraint(equalTo: titleLabel.centerXAnchor),
            emailLabel.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor, constant: 80),
            emailLabel.widthAnchor.constraint(equalToConstant: 200),
            emailLabel.heightAnchor.constraint(equalToConstant: 40),
            accessButton.centerXAnchor.constraint(equalTo: emailLabel.centerXAnchor),
            accessButton.centerYAnchor.constraint(equalTo: emailLabel.centerYAnchor, constant: 50),
            accessButton.widthAnchor.constraint(equalToConstant: 100),
            accessButton.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    
}
