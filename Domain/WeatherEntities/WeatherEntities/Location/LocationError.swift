//
//  LocationError.swift
//  WeatherEntities
//
//  Created by Andrés Bonilla Gómez on 11/10/24.
//

import Foundation

public enum LocationError: Error {
    case unavailableLocation
    case checkCLAAuthorization
    case unknown
}
