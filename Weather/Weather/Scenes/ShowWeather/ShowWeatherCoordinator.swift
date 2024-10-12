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
         coordinates: CLLocation) {
        self.navigatonController = navigatonController
        self.showWeatherViewController = ShowWeatherFactory.build(coordinates: coordinates)
    }
    
    func present() {
        
        guard let showWeatherViewController = showWeatherViewController else {
            return
        }
        
        navigatonController.present(showWeatherViewController, animated: true)
    }
}
