//
//  WelcomeViewController.swift
//  ChatUp
//
//  Created by Александра Кострова on 05.04.2023.
//

import UIKit

class WelcomeViewController: UIViewController, WelcomeViewDelegate {
    
    let welcomeView = WelcomeView()
    private var samples = Samples()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        welcomeView.delegate = self
        samples.setMyView(welcomeView, self.view)
        
        welcomeView.loginButton.addTarget(self,
                                          action: #selector(loginButtonPressed(sender:)),
                                          for: .touchUpInside)
        welcomeView.registerButton.addTarget(self,
                                             action: #selector(registerButtonPressed(sender:)),
                                             for: .touchUpInside)
    }
    
    @objc func registerButtonPressed(sender: UIButton) {
        navigationController?.pushViewController(RegisterViewController(), animated: true)
    }
    
    @objc func loginButtonPressed(sender: UIButton) {
        navigationController?.pushViewController(LoginViewController(), animated: true)
    }
}
