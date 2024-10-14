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
    
        
    func showAlertMessage(title: String, message: String, titleBtn: String) {
        
        let alertMessagePopUpBox = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: titleBtn, style: .default)
        
        alertMessagePopUpBox.addAction(okButton)
        self.present(alertMessagePopUpBox, animated: true)
    }
}

public extension Decodable {
    static var typeName: String {
        return String(describing: self)
    }
}
