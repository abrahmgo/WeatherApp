//
//  AskLocationViewModel+Dependencies.swift
//  Weather
//
//  Created by Andrés Bonilla Gómez on 14/10/24.
//

import WeatherUsecases

protocol AskLocationViewModelOutputs {
    
}

protocol AskLocationViewModelInputs {
}

protocol AskLocationViewModelType {
    var outputs: AskLocationViewModelOutputs { get }
    var inputs: AskLocationViewModelInputs { get }
}

struct AskLocationDependencies {
    
    let startLocation: StarLocalizationUseCaseType
}
