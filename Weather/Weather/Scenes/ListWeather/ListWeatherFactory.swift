//
//  ListWeatherFactory.swift
//  Weather
//
//  Created by Andrés Bonilla Gómez on 12/10/24.
//

struct ListWeatherFactory {
    
    static func makeListWeather(coordinator: ListWeatherCoordinator) -> ListWeatherViewController {
        
        // MARK: ViewModel
        let dependencies = ListWeatherDependencies()
        let viewModel = ListWeatherViewModel(dependencies: dependencies)
        
        // MARK: ViewController
        let viewController = ListWeatherViewController(coordinator: coordinator, viewModel: viewModel)
        return viewController
    }
}
