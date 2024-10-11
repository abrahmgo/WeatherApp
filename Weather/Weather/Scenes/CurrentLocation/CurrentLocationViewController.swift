//
//  CurrentLocationViewController.swift
//  Weather
//
//  Created by Andrés Bonilla Gómez on 11/10/24.
//

import UIKit

class CurrentLocationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public init() {
        super.init(nibName: "CurrentLocationViewController", bundle: Bundle(for: type(of: self)))
    }
    
}
