//
//  SplashViewModel.swift
//  Weather
//
//  Created by Andrés Bonilla Gómez on 14/10/24.
//

import Combine

class SplashViewModel: SplashViewModelType, SplashViewModelInputs, SplashViewModelOutputs {
    
    var goTo: PassthroughSubject<SplashViewPath, Never> = PassthroughSubject<SplashViewPath, Never>()
    
    var outputs: any SplashViewModelOutputs { return self }
    var inputs: any SplashViewModelInputs { return self }
    
    private let dependencies: SplashDependencies
    
    init(dependencies: SplashDependencies) {
        self.dependencies = dependencies
        Task {
            try await Task.sleep(for: .seconds(2))
            decidePath()
        }
    }
    
    func decidePath() {
        if !WeatherUserDefaults.firstLaunch {
            goTo.send(.tutorial)
            WeatherUserDefaults.firstLaunch = true
        } else {
            Task {
                if !WeatherUserDefaults.requestedNotification {
                    Task {
                        WeatherUserDefaults.requestedNotification = true
                        _ = try await dependencies.authNotification.execute()
                    }
                }
                goTo.send(.app)
            }
        }
    }
}
