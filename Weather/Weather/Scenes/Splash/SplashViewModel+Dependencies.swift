//
//  SplashViewModel+Dependencies.swift
//  Weather
//
//  Created by Andrés Bonilla Gómez on 14/10/24.
//

import Combine

protocol SplashViewModelOutputs {
    
    var goTo: PassthroughSubject<SplashViewPath, Never> { get }
}

protocol SplashViewModelInputs {
}

protocol SplashViewModelType {
    var outputs: SplashViewModelOutputs { get }
    var inputs: SplashViewModelInputs { get }
}

enum SplashViewPath {
    case tutorial
    case app
}
