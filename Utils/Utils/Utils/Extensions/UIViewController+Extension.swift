//
//  UIViewController+Extension.swift
//  Utils
//
//  Created by Andrés Bonilla Gómez on 11/10/24.
//

import UIKit

public extension UIViewController {
    
    static var typeName: String {
        return String(describing: self)
    }
}

public extension Decodable {
    static var typeName: String {
        return String(describing: self)
    }
}
