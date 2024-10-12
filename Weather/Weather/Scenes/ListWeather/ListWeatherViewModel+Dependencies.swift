//
//  ListWeatherViewModel+Dependencies.swift
//  Weather
//
//  Created by Andrés Bonilla Gómez on 12/10/24.
//

import UIKit
import Combine

public protocol ListWeatherViewModelOutputs {
    var components: CurrentValueSubject<[ListWeatherComponent], Never> { get }
    var isLoading: CurrentValueSubject<Bool, Never> { get }
    var error: PassthroughSubject<Error, Never> { get }
}

public protocol ListWeatherViewModelInputs { }

public protocol ListWeatherViewModelType {
    var outputs: ListWeatherViewModelOutputs { get }
    var inputs: ListWeatherViewModelInputs { get }
}

public struct ListWeatherDependencies { }
