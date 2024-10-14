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
                        featureUse: ShowWeatherUse = .read) {
        
        guard let navigation = listWeatherViewController?.navigationController,
              let listWeatherViewController = listWeatherViewController else {
            return
        }
        ShowWeatherCoordinator(navigatonController: navigation,
                               coordinates: coordinates,
                               delegate: listWeatherViewController,
                               featureUse: featureUse).present()
    }
}
