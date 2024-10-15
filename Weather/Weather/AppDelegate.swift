//
//  AppDelegate.swift
//  Weather
//
//  Created by Andrés Bonilla Gómez on 11/10/24.
//

import UIKit
import NetoworkCore
import CoreLocation
import Localizable

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        doNetwork()
        window = UIWindow()
        doAppearence()
        SplashCoordinator().start()
        
        return true
    }
    
    func doNetwork() {
        NetworkCoreAPI.setup(with: APIConfig.self)
        LocalizableService.shared = LocalizableService(language: LocalizableLanguage(rawValue: APIConfig.language) ?? .es)
    }
    
    func doAppearence() {
        UINavigationBar.appearance().prefersLargeTitles = true
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        UINavigationBar.appearance().largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        UINavigationBar.appearance().barTintColor = .clear
        
        let proxy = UIPageControl.appearance()
        proxy.pageIndicatorTintColor = UIColor.lightGray.withAlphaComponent(0.6)
        proxy.currentPageIndicatorTintColor = .white
        proxy.backgroundColor = .black
    }
}
