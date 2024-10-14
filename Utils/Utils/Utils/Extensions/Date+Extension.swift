//
//  Date+Extension.swift
//  Utils
//
//  Created by Andrés Bonilla Gómez on 14/10/24.
//

import Foundation

public extension Date {
    
    func toSring(format: DateFormat) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.rawValue
        dateFormatter.locale = .current
        let stringDate = dateFormatter.string(from: self)
        return stringDate
    }
}

public enum DateFormat: String {
    
    case completeYearMonthDaySlash = "dd/MM/yyyy"
}
