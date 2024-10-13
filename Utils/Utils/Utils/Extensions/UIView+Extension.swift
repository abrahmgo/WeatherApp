//
//  UIView+Extension.swift
//  Utils
//
//  Created by Andrés Bonilla Gómez on 12/10/24.
//

import UIKit

public extension UIView {
    
    func addRoundShadow(colorShadow shadow: UIColor = .black,
                        colorBack background: UIColor = .white,
                        opacity: Float = 0.5,
                        offset: CGSize = .zero,
                        radius: CGFloat = 6) {
        layer.cornerRadius = radius
        layer.masksToBounds = true

        backgroundColor = background
        layer.shadowColor = shadow.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offset
        layer.shadowRadius = radius / 2
        layer.masksToBounds = false
    }
}
