//
//  NotificationViewModel.swift
//  Weather
//
//  Created by Andrés Bonilla Gómez on 14/10/24.
//

import Foundation

class NotificationViewModel: NotificationViewModelType, NotificationViewModelOutputs, NotificationViewModelInputs {
    
    var outputs: any NotificationViewModelOutputs { return self }
    var inputs: any NotificationViewModelInputs { return self }
    
    private let dependencies: NotificationDependencies
    
    init(dependencies: NotificationDependencies) {
        self.dependencies = dependencies
    }
}
