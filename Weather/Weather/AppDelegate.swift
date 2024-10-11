//
//  AppDelegate.swift
//  Weather
//
//  Created by Andrés Bonilla Gómez on 11/10/24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow()
        window?.rootViewController = CurrentLocationViewController()
        window?.makeKeyAndVisible()
        
        return true
    }
}

