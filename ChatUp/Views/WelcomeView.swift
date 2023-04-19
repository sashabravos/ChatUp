//
//  WelcomeView.swift
//  ChatUp
//
//  Created by Александра Кострова on 10.04.2023.
//

import UIKit
import CLTypingLabel

protocol WelcomeViewDelegate: AnyObject {
    
}

final class WelcomeView: UIView {
    
    weak var delegate: WelcomeViewDelegate?
    private var samples = Samples()
    
    lazy var loginButton = samples.loginButton
    lazy var registerButton = samples.registerButton
    
    lazy var appNameLabel: CLTypingLabel = {
        let label = CLTypingLabel()
        label.numberOfLines = 1
        label.textColor = Samples.Colors.blue
        label.font = .systemFont(ofSize: 50.0, weight: .black)
        label.textAlignment = .natural
        label.isEnabled = true
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setSubViews()
        appNameLabel.text = "ChatUP! 😍"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setSubViews() {
        self.backgroundColor = .white

        [appNameLabel, registerButton, loginButton].forEach {
            self.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            appNameLabel.trailingAnchor.constraint(greaterThanOrEqualTo: self.safeAreaLayoutGuide.trailingAnchor),
            appNameLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 52.0),
            appNameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            appNameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            appNameLabel.heightAnchor.constraint(equalToConstant: 60.0),
            
            registerButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            registerButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            registerButton.heightAnchor.constraint(equalToConstant: 48.0),
            
            loginButton.heightAnchor.constraint(equalToConstant: 61.0),
            loginButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            loginButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            loginButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            loginButton.topAnchor.constraint(equalTo: registerButton.bottomAnchor)
        ])
    }
}
