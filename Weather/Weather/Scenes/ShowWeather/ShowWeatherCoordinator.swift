//
//  ShowWeatherCoordinator.swift
//  Weather
//
//  Created by Andrés Bonilla Gómez on 12/10/24.
//

import UIKit
import CoreLocation

struct ShowWeatherCoordinator {
    
    private let navigatonController: UINavigationController
    private var showWeatherViewController: ShowWeatherViewController?
    
    init(navigatonController: UINavigationController,
         coordinates: CLLocation,
         delegate: ShowWeatherDelegate? = nil) {
        self.navigatonController = navigatonController
        self.showWeatherViewController = ShowWeatherFactory.build(coordinates: coordinates, delegate: delegate)
    }
    
    func present() {
        
        guard let showWeatherViewController = showWeatherViewController else {
            return
        }
        let viewController = UINavigationController(rootViewController: showWeatherViewController)
        navigatonController.present(viewController, animated: true)
    }
}
