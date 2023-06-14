//
//  RegisterViewController.swift
//  ChatUp
//
//  Created by Александра Кострова on 05.04.2023.
//

import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController, RegisterViewDelegate {
    
    private var samples = Samples()
    private var registerView = RegisterView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerView.delegate = self
        samples.setMyView(registerView, self.view)
        self.navigationController?.navigationBar.backgroundColor = .none
        
        registerView.registerButton.addTarget(self, action: #selector(buttonPressed(sender:)), for: .touchUpInside)
    }
    
    @objc func buttonPressed(sender: UIButton) {
        
        if let email = registerView.emailTF.text, let password = registerView.passwordTF.text {
            Auth.auth().createUser(withEmail: email, password: password) { _, error in
                if let registerError = error {
                    
                    let alert = UIAlertController(title: "Error", message: "\(registerError.localizedDescription)", preferredStyle: .alert)
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
