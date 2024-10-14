//
//  NotificationViewModel+Dependencies.swift
//  Weather
//
//  Created by Andrés Bonilla Gómez on 14/10/24.
//

import WeatherUsecases

protocol NotificationViewModelOutputs {
    
}

protocol NotificationViewModelInputs {
    
    func requestAuthNotification()
}

protocol NotificationViewModelType {
    var outputs: NotificationViewModelOutputs { get }
    var inputs: NotificationViewModelInputs { get }
}

struct NotificationDependencies {
    
    let authNotification: GetLocalNotifcationAuthUsecaseType
}
