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
//        if let email = loginView.emailTF.text, let password = loginView.passwordTF.text {
//            Auth.auth().signIn(withEmail: email, password: password) { _, error in
//                if let loginError = error {
//                    print(loginError.localizedDescription)
//                    let alert = UIAlertController(title: "Mistake!",
//                                                  message: "You have an error in your email or password.",
//                                                  preferredStyle: .alert)
//                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
//                        switch action.style {
//                        case .cancel:
//                            print("cancel")
//                        case .destructive:
//                            print("destructive")
//                        default:
//                            print("default")
//                        }
//                    }))
//                    self.present(alert, animated: true, completion: nil)
//                } else {
//                    // Navigate to the ChatVC
//                    self.navigationController?.pushViewController(ChatViewController(), animated: true)
//                }
//            }
//        }
        self.navigationController?.pushViewController(ChatViewController(), animated: true)
    }
}
