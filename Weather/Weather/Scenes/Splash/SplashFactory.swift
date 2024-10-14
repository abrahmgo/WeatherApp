//
//  SplashFactory.swift
//  Weather
//
//  Created by Andrés Bonilla Gómez on 14/10/24.
//

import WeatherUsecases

struct SplashFactory {
    
    static func makeSplash(coordinator: SplashCoordinator) -> SplashViewController {
        
        let authNotification = GetLocalNotifcationAuthUsecase()
        let dependencies = SplashDependencies(authNotification: authNotification)
        let viewModel = SplashViewModel(dependencies: dependencies)
        
        // MARK: ViewController
        let viewController = SplashViewController(coordinator: coordinator, viewModel: viewModel)
        return viewController
    }
}
