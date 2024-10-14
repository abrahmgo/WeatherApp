//
//  SplashCoordinator.swift
//  Weather
//
//  Created by Andrés Bonilla Gómez on 14/10/24.
//

import UIKit

struct SplashCoordinator {
    
    private var splashViewController: SplashViewController?
    
    init() {
        self.splashViewController = SplashFactory.makeSplash(coordinator: self)
    }
    
    func start() {
        guard let splashViewController = splashViewController else {
            return
        }
        
        setRootViewController(splashViewController)
    }
    
    private func setRootViewController(_ viewController: UIViewController?) {
        
        guard let window = (UIApplication.shared.delegate as? AppDelegate)?.window else {
            return
        }
        
        window.rootViewController = viewController
        window.makeKeyAndVisible()
    }
    
    func goToApp() {
        ListWeatherCoordinator().start()
    }
    
    func goToTutorial() {
        TutorialCoordinator().start()
    }
}
