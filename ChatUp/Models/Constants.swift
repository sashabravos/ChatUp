//
//  Constants.swift
//  ChatUp
//
//  Created by Александра Кострова on 14.06.2023.
//

import Foundation
import UIKit

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
