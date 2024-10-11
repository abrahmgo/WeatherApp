//
//  LocationRemoteDataSource.swift
//  WeatherDataSource
//
//  Created by Andrés Bonilla Gómez on 11/10/24.
//

import Combine
import WeatherEntities
import CoreLocation

public protocol LocationServiceType {
    func askLocationPermits(type: RequestLocationType) async throws
    func requestLocation() async throws
    func authorizationStatus() async throws -> CLAuthorizationStatus
    
    var currentLocation: PassthroughSubject<CLLocation, Error> { get }
    var currentAuthStatus: PassthroughSubject<CLAuthorizationStatus, Never> { get }
}
