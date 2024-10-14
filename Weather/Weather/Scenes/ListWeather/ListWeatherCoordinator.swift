//
//  ListWeatherCoordinator.swift
//  Weather
//
//  Created by Andrés Bonilla Gómez on 12/10/24.
//

import UIKit
import Utils
import CoreLocation
import WeatherEntities

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
    
    func presentWeather(localWeather: LocalWeather,
                        featureUse: ShowWeatherUse = .read) {
        
        guard let navigation = listWeatherViewController?.navigationController,
              let listWeatherViewController = listWeatherViewController else {
            return
        }
        ShowWeatherCoordinator(navigatonController: navigation,
                               localWeather: localWeather,
                               delegate: listWeatherViewController,
                               featureUse: featureUse).present()
    }
}
