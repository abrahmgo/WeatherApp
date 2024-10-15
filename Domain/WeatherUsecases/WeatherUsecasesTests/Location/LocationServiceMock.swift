//
//  LocationServiceMock.swift
//  WeatherUsecasesTests
//
//  Created by Andrés Bonilla Gómez on 15/10/24.
//

import WeatherDataSource
import Combine
import WeatherEntities
import CoreLocation

struct LocationServiceMock: LocationServiceType {
    
    func askLocationPermits(type: WeatherEntities.RequestLocationType) async throws { }
    
    func requestLocation() async throws { }
    
    func authorizationStatus() async throws -> CLAuthorizationStatus {
        return .authorizedAlways
    }
    
    var currentLocation: PassthroughSubject<CLLocation, Error> = PassthroughSubject<CLLocation, Error>()
    
    var currentAuthStatus: PassthroughSubject<CLAuthorizationStatus, Never> = PassthroughSubject<CLAuthorizationStatus, Never>()
}
