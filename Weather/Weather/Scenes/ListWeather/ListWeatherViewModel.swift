//
//  ListWeatherViewModel.swift
//  Weather
//
//  Created by Andrés Bonilla Gómez on 12/10/24.
//

import Combine

class ListWeatherViewModel: ListWeatherViewModelType, ListWeatherViewModelInputs, ListWeatherViewModelOutputs {

    // MARK: Properties
    var outputs: ListWeatherViewModelOutputs { return self }
    var inputs: ListWeatherViewModelInputs { return self }
    
    // MARK: Inputs
    
    // MARK: Outputs
    // MARK: Outputs
    var components: CurrentValueSubject<[ListWeatherComponent], Never> = CurrentValueSubject([])
    var isLoading: CurrentValueSubject<Bool, Never> = CurrentValueSubject(false)
    var error: PassthroughSubject<Error, Never> = PassthroughSubject()
    
    // MARK: Private
    private let dependencies: ListWeatherDependencies
    private var cancellable: Set<AnyCancellable> = Set<AnyCancellable>()
    
    init(dependencies: ListWeatherDependencies) {
        self.dependencies = dependencies
    }
}
