//
//  TutorialCoordinator.swift
//  Weather
//
//  Created by Andrés Bonilla Gómez on 14/10/24.
//

import UIKit

struct TutorialCoordinator {
    
    private var tutorialViewController: TutorialViewController?
    
    init() {
        self.tutorialViewController = TutorialFactory.makeTutorial(coordinator: self)
    }
    
    func start() {
        guard let tutorialViewController = tutorialViewController else {
            return
        }
        
        setRootViewController(tutorialViewController)
    }
    
    private func setRootViewController(_ viewController: UIViewController?) {
        
        guard let window = (UIApplication.shared.delegate as? AppDelegate)?.window else {
            return
        }
        
        window.rootViewController = viewController
        window.makeKeyAndVisible()
    }
}
