//
//  LoginViewController.swift
//  ChatUp
//
//  Created by Александра Кострова on 05.04.2023.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController, LoginViewDelegate {
    
    private var samples = Samples()
    private var loginView = LoginView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginView.delegate = self
        samples.setMyView(loginView, self.view)
        
        loginView.loginButton.addTarget(self, action: #selector(buttonPressed(sender:)), for: .touchUpInside)
    }
    
    @objc func buttonPressed(sender: UIButton) {
        if let email = loginView.emailTF.text, let password = loginView.passwordTF.text {
            Auth.auth().signIn(withEmail: email, password: password) { _, error in
                if let loginError = error {
                    let alert = UIAlertController(title: "Error",
                                                  message: "\(loginError.localizedDescription)",
                                                  preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .cancel))
                    self.present(alert, animated: true, completion: nil)
                } else {
                    // Navigate to the ChatVC
                    self.navigationController?.pushViewController(ChatViewController(), animated: true)
                }
            }
        }
    }
}
