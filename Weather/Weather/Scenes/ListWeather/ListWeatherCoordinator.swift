//
//  ListWeatherCoordinator.swift
//  Weather
//
//  Created by Andrés Bonilla Gómez on 12/10/24.
//

import UIKit
import Utils
import CoreLocation

class ListWeatherCoordinator {
    
    private var listWeatherViewController: ListWeatherViewController?
    
    init() {
        self.listWeatherViewController = ListWeatherFactory.makeListWeather(coordinator: self)
    }
    
    func start() {
        guard let listWeatherViewController = listWeatherViewController else {
            return
        }
        
        let viewContoller = UINavigationController(rootViewController: listWeatherViewController)
        UINavigationBar.appearance().prefersLargeTitles = true
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        UINavigationBar.appearance().largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        setRootViewController(viewContoller)
    }
    
    private func setRootViewController(_ viewController: UIViewController?) {
        
        guard let window = (UIApplication.shared.delegate as? AppDelegate)?.window else {
            return
        }
        
        window.rootViewController = viewController
        window.makeKeyAndVisible()
    }
    
    func presentWeather(coordinates: CLLocation,
                        isCurrentLocation: Bool = false) {
        
        guard let navigation = listWeatherViewController?.navigationController,
              let listWeatherViewController = listWeatherViewController else {
            return
        }
        ShowWeatherCoordinator(navigatonController: navigation,
                               coordinates: coordinates,
                               delegate: listWeatherViewController,
                               isCurrentLocation: isCurrentLocation).present()
    }
}
