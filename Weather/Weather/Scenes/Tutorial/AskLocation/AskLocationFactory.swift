//
//  AskLocationFactory.swift
//  Weather
//
//  Created by Andrés Bonilla Gómez on 14/10/24.
//

import WeatherUsecases
import WeatherCore

struct AskLocationFactory {
    
    static func makeAskLocation(coordinator: AskLocationCoordinator) -> AskLocationViewController {
        
        let locationService = WeatherLocalDataSource.location
        let startLocation = StarLocalizationUseCase(locationService: locationService)
        let dependencies = AskLocationDependencies(startLocation: startLocation)
        let viewModel = AskLocationViewModel(dependencies: dependencies)
        
        // MARK: ViewController
        let viewController = AskLocationViewController(viewModel: viewModel)
        return viewController
    }
}
