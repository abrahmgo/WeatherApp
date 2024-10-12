//
//  Double+Extension.swift
//  Utils
//
//  Created by Andrés Bonilla Gómez on 12/10/24.
//

import Foundation

public extension Double {
    
    func roundTo(_ places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
    
    func roundToNf(_ decimals: Int) -> String {
        return String(format: "%.\(decimals)f%%", self)
    }
    
    func toInt() -> Int {
        if self >= Double(Int.min) && self < Double(Int.max) {
            return Int(self)
        } else {
            return 0
        }
    }
}
