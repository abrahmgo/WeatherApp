//
//  Address.swift
//  WeatherEntities
//
//  Created by Andrés Bonilla Gómez on 11/10/24.
//

import CoreLocation
import MapKit

public struct Address {
    
    public let coordinates: CLLocationCoordinate2D
    public var country: String
    public let state: String
    public let city: String
    public let town: String
    public let street: String
    public var number: String
    public var interior: String
    public let zipCode: String
    public var idUser: String
    public var id: String
    
    public init(coordinates: CLLocationCoordinate2D = .init(latitude: .zero, longitude: .zero),
                country: String = "",
                state: String = "",
                city: String = "",
                town: String = "",
                street: String = "",
                number: String = "",
                interior: String = "",
                zipCode: String = "",
                idUser: String = "",
                id: String = "") {
        self.coordinates = coordinates
        self.country = country
        self.state = state
        self.city = city
        self.town = town
        self.street = street
        self.number = number
        self.interior = interior
        self.zipCode = zipCode
        self.idUser = idUser
        self.id = id
    }
    
    public init(place: MKPlacemark) {
        self.coordinates = place.coordinate
        self.country = place.country ?? "México"
        self.state = place.administrativeArea ?? ""
        self.city = place.subAdministrativeArea ?? ""
        self.town = place.subLocality ?? ""
        self.street = place.thoroughfare ?? ""
        self.number = Address.getNumber(name: place.name ?? "") ?? ""
        self.interior = ""
        self.zipCode = place.postalCode ?? "0"
        self.idUser = ""
        self.id = ""
    }
    
    public init(place: CLPlacemark) {
        self.coordinates = place.location?.coordinate ?? .init(latitude: .zero, longitude: .zero)
        self.country = place.country ?? "México"
        self.state = place.administrativeArea ?? ""
        self.city = place.subAdministrativeArea ?? ""
        self.town = place.subLocality ?? ""
        self.street = place.thoroughfare ?? ""
        self.number = Address.getNumber(name: place.name ?? "") ?? ""
        self.interior = ""
        self.zipCode = place.postalCode ?? "0"
        self.idUser = ""
        self.id = ""
    }
    
    public func getFullAddress() -> String {
        return "\(street) \(number) \(interior) \(town) \(city) \(state) \(zipCode) \(country)"
    }
    
    private static func getNumber(name: String) -> String? {
        let split = name.components(separatedBy: " ")
        let last = split.last
        return last
    }
}

