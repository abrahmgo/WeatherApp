//
//  SplashFactory.swift
//  Weather
//
//  Created by Andrés Bonilla Gómez on 14/10/24.
//

import Foundation

struct SplashFactory {
    
    static func makeSplash(coordinator: SplashCoordinator) -> SplashViewController {
        
        let viewModel = SplashViewModel()
        
        // MARK: ViewController
        let viewController = SplashViewController(coordinator: coordinator, viewModel: viewModel)
        return viewController
    }
}
