//
//  AskLocationViewModel.swift
//  Weather
//
//  Created by Andrés Bonilla Gómez on 14/10/24.
//

import Foundation

class AskLocationViewModel: AskLocationViewModelType, AskLocationViewModelOutputs, AskLocationViewModelInputs {
    
    var outputs: any AskLocationViewModelOutputs { return self }
    var inputs: any AskLocationViewModelInputs { return self }
    
    private let dependencies: AskLocationDependencies
    
    init(dependencies: AskLocationDependencies) {
        self.dependencies = dependencies
    }
}
