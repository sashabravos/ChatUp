//
//  Samples.swift
//  ChatUp
//
//  Created by Александра Кострова on 05.04.2023.
//

import UIKit

struct Samples {
    
    // MARK: - Views
    
    lazy var loginButton = anyBigButton("Log In",
                                        titleColor: .white,
                                        backgroundColor: Colors.blue)
    
    lazy var registerButton = anyBigButton("Register",
                                           titleColor: Colors.blue,
                                           backgroundColor: Colors.lightBlue)
    
    lazy var emailTF = entranceTextFields("Email",
                                          secure: false,
                                          keyboardType: .emailAddress)
    lazy var passwordTF = entranceTextFields("Password",
                                             secure: true,
                                             keyboardType: .default)

    // MARK: - Functions
    
    public func makeView() -> UIView {
        let newView = UIView()
        newView.backgroundColor = .clear
        newView.contentMode = .scaleToFill
        return newView
    }
    
    private func anyBigButton(_ title: String,
                              titleColor: UIColor,
                              backgroundColor: UIColor) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.backgroundColor = backgroundColor
        button.titleLabel!.numberOfLines = 0
        button.setTitleColor(titleColor, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: Constants.buttonsFontSize, weight: .regular)
        return button
    }
    
    private func entranceTextFields(_ title: String, secure: Bool, keyboardType: UIKeyboardType) -> UITextField {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(
            string: title,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray .withAlphaComponent(0.7)]
        )
        textField.textAlignment = .center
        textField.textColor = .black
        textField.minimumFontSize = Constants.textFieldMinFontSize
        textField.font = UIFont.systemFont(ofSize: Constants.textFielFontSize)
        textField.contentHorizontalAlignment = .left
        textField.keyboardType = keyboardType
        textField.backgroundColor = .white
        textField.isSecureTextEntry = secure
        textField.layer.cornerRadius = Constants.textFieldCornerRadius
        textField.layer.shadowOpacity = Constants.textFieldShadowOpacity
        textField.layer.shadowRadius = Constants.textFieldShadowRadius
        textField.layer.shadowOffset = Constants.textFieldShadowOffset
        textField.layer.shadowColor = UIColor.lightGray.cgColor
        return textField
    }
    
    public func setMyView(_ myView: UIView, _ replaceView: UIView) {
        replaceView.addSubview(myView)
        myView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            myView.topAnchor.constraint(equalTo: replaceView.topAnchor),
            myView.leadingAnchor.constraint(equalTo: replaceView.leadingAnchor),
            myView.trailingAnchor.constraint(equalTo: replaceView.trailingAnchor),
            myView.bottomAnchor.constraint(equalTo: replaceView.bottomAnchor)
        ])
    }
    
    private enum Constants {
        
        static let buttonsFontSize: CGFloat = 30.0
        
        static let textFieldMinFontSize: CGFloat = 17.0
        static let textFielFontSize: CGFloat = 25.0
        static let textFieldCornerRadius: CGFloat = 28.0
        static let textFieldShadowOpacity: Float = 1.0
        static let textFieldShadowRadius: CGFloat = 5.0
        static let textFieldShadowOffset = CGSize(width: 1.0, height: 2.0)
    }
    
    public enum Colors {

        static let blue = UIColor(named: "BrandBlue") ?? UIColor()
        static let lightBlue = UIColor(named: "BrandLightBlue") ?? UIColor()
        static let purple = UIColor(named: "BrandPurple") ?? UIColor()
        static let lightPurple = UIColor(named: "BrandLightPurple") ?? UIColor()
    }
    
    public enum Avatars {
        
        static let blueFace = UIImage(named: "blueFace")
        static let yellowFace = UIImage(named: "yellowFace")
        static let purpleFace = UIImage(named: "purpleFace")
        static let pinkFace = UIImage(named: "pinkFace")
        static let greenFace = UIImage(named: "greenFace")
    }
    
    public enum FStore {
        static let collectionName = "messages"
        static let senderField = "sender"
        static let bodyField = "body"
        static let dateField = "date"
    }
}
