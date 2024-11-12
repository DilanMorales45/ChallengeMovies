//
//  LoginView.swift
//  ChallengeMovies
//
//  Created by Mario Alfonso Orozco Pacheco on 7/11/24.
//

import UIKit

protocol LoginViewDelegate: AnyObject {
    func loginView(_ view: LoginView, didSignWith user: String?)
}

class LoginView: UIView {

    // MARK: - Properties
    weak var delegate: LoginViewDelegate?
    
    // MARK: - UI Components
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "Cinemark"
        label.font = UIFont(name: "Arial Rounded MT Bold", size: 36)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var emailLabel: UITextField = {
        let text = UITextField()
        text.backgroundColor = .lightGray
        text.attributedPlaceholder = NSAttributedString(
            string: "",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]
        )
        text.borderStyle = .roundedRect
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    lazy var accessButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var translateSpanishButton: UIButton = {
        var config = UIButton.Configuration.bordered()
        config.title = "ES"
        config.image = UIImage(systemName: "translate")
        
        let button = UIButton(type: .system)
        button.configuration = config
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var translateEnglishButton: UIButton = {
        var config = UIButton.Configuration.bordered()
        config.title = "EN"
        config.image = UIImage(systemName: "translate")
        
        let button = UIButton(type: .system)
        button.configuration = config
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupSubviews()
        self.setupConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupSubviews()
        self.setupConstraints()
    }
    
    // MARK: - Setup Methods
    private func setupSubviews() {
        self.backgroundColor = .white
        self.addSubview(self.titleLabel)
        self.addSubview(self.emailLabel)
        self.addSubview(self.accessButton)
        self.addSubview(self.translateSpanishButton)
        self.addSubview(self.translateEnglishButton)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            self.titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            self.titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -40),
            self.titleLabel.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            
            self.emailLabel.centerXAnchor.constraint(equalTo: titleLabel.centerXAnchor),
            self.emailLabel.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor, constant: 80),
            self.emailLabel.widthAnchor.constraint(equalToConstant: 200),
            self.emailLabel.heightAnchor.constraint(equalToConstant: 40),
            
            self.accessButton.centerXAnchor.constraint(equalTo: emailLabel.centerXAnchor),
            self.accessButton.centerYAnchor.constraint(equalTo: emailLabel.centerYAnchor, constant: 50),
            self.accessButton.widthAnchor.constraint(equalToConstant: 100),
            self.accessButton.heightAnchor.constraint(equalToConstant: 40),
            
            self.translateSpanishButton.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            self.translateSpanishButton.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            
            self.translateEnglishButton.topAnchor.constraint(equalTo: translateSpanishButton.topAnchor),
            self.translateEnglishButton.trailingAnchor.constraint(equalTo: translateSpanishButton.trailingAnchor, constant: -90)
        ])
    }
}
