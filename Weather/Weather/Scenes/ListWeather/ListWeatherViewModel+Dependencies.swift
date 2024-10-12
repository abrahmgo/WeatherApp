//
//  ListWeatherViewModel+Dependencies.swift
//  Weather
//
//  Created by Andrés Bonilla Gómez on 12/10/24.
//

import UIKit
import WeatherUsecases
import Combine

 protocol ListWeatherViewModelOutputs {
    var components: CurrentValueSubject<[ListWeatherComponent], Never> { get }
    var isLoading: CurrentValueSubject<Bool, Never> { get }
    var error: PassthroughSubject<Error, Never> { get }
}

 protocol ListWeatherViewModelInputs { }

 protocol ListWeatherViewModelType {
    var outputs: ListWeatherViewModelOutputs { get }
    var inputs: ListWeatherViewModelInputs { get }
}

 struct ListWeatherDependencies { 
}
