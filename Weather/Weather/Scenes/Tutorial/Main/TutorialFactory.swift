//
//  TutorialFactory.swift
//  Weather
//
//  Created by Andrés Bonilla Gómez on 14/10/24.
//

import Foundation

struct TutorialFactory {
    
    static func makeTutorial(coordinator: TutorialCoordinator) -> TutorialViewController {
        
        
        let viewController = TutorialViewController(transitionStyle: .scroll,
                                                    navigationOrientation: .horizontal,
                                                    options: [:])
        return viewController
    }
}
