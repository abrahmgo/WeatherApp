//
//  SplashFactory.swift
//  Weather
//
//  Created by Andrés Bonilla Gómez on 14/10/24.
//

import WeatherUsecases
import WeatherCore

struct SplashFactory {
    
    static func makeSplash(coordinator: SplashCoordinator) -> SplashViewController {
        
        let notificationService = WeatherLocalDataSource.notification
        let authNotification = RequestAuthLocalNotificationUsecase(localNotification: notificationService)
        let dependencies = SplashDependencies(authNotification: authNotification)
        let viewModel = SplashViewModel(dependencies: dependencies)
        
        // MARK: ViewController
        let viewController = SplashViewController(coordinator: coordinator, viewModel: viewModel)
        return viewController
    }
}
