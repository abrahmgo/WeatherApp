//
//  LocationService.swift
//  WeatherCore
//
//  Created by Andrés Bonilla Gómez on 11/10/24.
//

import CoreLocation
import WeatherEntities
import WeatherDataSource
import Combine

class LocationService: NSObject, LocationServiceType {
    
    private let locationManager: CLLocationManager = CLLocationManager()
    var currentLocation: PassthroughSubject<CLLocation, Error> = PassthroughSubject<CLLocation, Error>()
    var currentAuthStatus: PassthroughSubject<CLAuthorizationStatus, Never> = PassthroughSubject<CLAuthorizationStatus, Never>()
    
    override init() {
        super.init()
        
        locationManager.delegate = self
    }
    
    func askLocationPermits(type: WeatherEntities.RequestLocationType) async throws {
        switch type {
        case .always:
            locationManager.requestAlwaysAuthorization()
        case .whenInUse:
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func requestLocation() async throws {
        locationManager.requestLocation()
    }
    
    func authorizationStatus() async throws -> CLAuthorizationStatus {
        return locationManager.authorizationStatus
    }
}

extension LocationService: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let firstLocation = locations.first {
            currentLocation.send(firstLocation)
        } else {
            
        }
    }
    
    func locationManager(_ manager: CLLocationManager,
                                didChangeAuthorization status: CLAuthorizationStatus) {
        currentAuthStatus.send(status)
    }
    
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        currentLocation.send(completion: .failure(error))
    }
}
