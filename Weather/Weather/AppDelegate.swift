//
//  AppDelegate.swift
//  Weather
//
//  Created by Andrés Bonilla Gómez on 11/10/24.
//

import UIKit
import NetoworkCore
import CoreLocation

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        doNetwork()
        window = UIWindow()
//        let coordinates = WeatherCoordinates(latitude: 19.617107, longitude: -99.086664)
//        let coordinates = CLLocation(latitude: 19.617107, longitude: -99.086664)
        ListWeatherCoordinator().start()
        
        return true
    }
    
    func doNetwork() {
        NetworkCoreAPI.setup(with: APIConfig.self)
    }
}
