//
//  ShowWeatherCoordinator.swift
//  Weather
//
//  Created by Andrés Bonilla Gómez on 12/10/24.
//

import UIKit
import CoreLocation
import WeatherEntities

struct ShowWeatherCoordinator {
    
    private let navigatonController: UINavigationController
    private var showWeatherViewController: ShowWeatherViewController?
    
    init(navigatonController: UINavigationController,
         localWeather: LocalWeather,
         delegate: ShowWeatherDelegate? = nil,
         featureUse: ShowWeatherUse = .read) {
        self.navigatonController = navigatonController
        self.showWeatherViewController = ShowWeatherFactory.build(localWeather: localWeather, 
                                                                  delegate: delegate,
                                                                  featureUse: featureUse)
    }
    
    func present() {
        
        guard let showWeatherViewController = showWeatherViewController else {
            return
        }
        let viewController = UINavigationController(rootViewController: showWeatherViewController)
        viewController.isModalInPresentation = true
        navigatonController.present(viewController, animated: true)
    }
}
