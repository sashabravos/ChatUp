//
//  LoginView.swift
//  ChatUp
//
//  Created by Александра Кострова on 10.04.2023.
//

import UIKit

protocol LoginViewDelegate: AnyObject {
    
}

final class LoginView: UIView {
    
    weak var delegate: LoginViewDelegate?
    private var samples = Samples()
    
    private lazy var emailView: UIView = {
        let view = samples.makeView()
        
        view.addSubview(emailTF)
        emailTF.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var passwordView: UIView = {
        let view = samples.makeView()
        
        [passwordTF, loginButton].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        return view
    }()
    
    lazy var loginButton = samples.loginButton
    lazy var emailTF = samples.emailTF
    lazy var passwordTF = samples.passwordTF
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setSubViews()
        //Delete this
        emailTF.text = "me@mail.com"
        passwordTF.text = "qwerty"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setSubViews() {
        
        self.backgroundColor = Samples.Colors.blue
        
        [emailView, passwordView, UINavigationBar()].forEach {
            self.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            emailView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            emailView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            emailView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            emailView.heightAnchor.constraint(equalToConstant: 80.0),
            
            passwordView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            passwordView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            passwordView.topAnchor.constraint(equalTo: emailView.bottomAnchor),
            passwordView.heightAnchor.constraint(equalToConstant: 160.0),
            
            emailTF.topAnchor.constraint(equalTo: emailView.topAnchor, constant: 25.0),
            emailTF.leftAnchor.constraint(equalTo: emailView.leftAnchor, constant: 48.0),
            emailTF.rightAnchor.constraint(equalTo: emailView.rightAnchor, constant: -48.0),
            emailTF.heightAnchor.constraint(equalToConstant: 60.0),
            
            passwordTF.topAnchor.constraint(equalTo: passwordView.topAnchor, constant: 25.0),
            passwordTF.leftAnchor.constraint(equalTo: passwordView.leftAnchor, constant: 48.0),
            passwordTF.rightAnchor.constraint(equalTo: passwordView.rightAnchor, constant: -48.0),
            passwordTF.heightAnchor.constraint(equalToConstant: 60.0),
            
            loginButton.leadingAnchor.constraint(equalTo: passwordView.leadingAnchor),
            loginButton.trailingAnchor.constraint(equalTo: passwordView.trailingAnchor),
            loginButton.bottomAnchor.constraint(equalTo: passwordView.bottomAnchor),
            loginButton.topAnchor.constraint(equalTo: passwordTF.bottomAnchor, constant: 10.0)
        ])
    }
}
