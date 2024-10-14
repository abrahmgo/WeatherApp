//
//  NotificationFactory.swift
//  Weather
//
//  Created by Andrés Bonilla Gómez on 14/10/24.
//

import WeatherUsecases
import WeatherCore

struct NotificationFactory {
    
    static func makeNotification(coordinator: NotificationCoordinator) -> NotificationViewController {
        
        let authNotification = GetLocalNotifcationAuthUsecase()
        let dependencies = NotificationDependencies(authNotification: authNotification)
        let viewModel = NotificationViewModel(dependencies: dependencies)
        
        // MARK: ViewController
        let viewController = NotificationViewController(viewModel: viewModel)
        return viewController
    }
}
