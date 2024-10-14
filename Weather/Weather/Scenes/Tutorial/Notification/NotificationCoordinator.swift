//
//  NotificationCoordinator.swift
//  Weather
//
//  Created by Andrés Bonilla Gómez on 14/10/24.
//

import UIKit

struct NotificationCoordinator {
    
    private var notificationViewController: NotificationViewController?
    
    init() {
        self.notificationViewController = NotificationFactory.makeNotification(coordinator: self)
    }
    
    func get() -> UIViewController {
        guard let notificationViewController = notificationViewController else {
            return UIViewController()
        }
        
        return notificationViewController
    }
}
