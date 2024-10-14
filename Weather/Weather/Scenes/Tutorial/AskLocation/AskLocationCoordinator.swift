//
//  AskLocationCoordinator.swift
//  Weather
//
//  Created by Andrés Bonilla Gómez on 14/10/24.
//

import UIKit

struct AskLocationCoordinator {
    
    private var askLocationViewController: AskLocationViewController?
    
    init() {
        self.askLocationViewController = AskLocationFactory.makeAskLocation(coordinator: self)
    }
    
    func get() -> UIViewController {
        guard let askLocationViewController = askLocationViewController else {
            return UIViewController()
        }
        
        return askLocationViewController
    }
}
