//
//  AskLocationViewController.swift
//  Weather
//
//  Created by Andrés Bonilla Gómez on 13/10/24.
//

import UIKit
import Utils

class AskLocationViewController: UIViewController {

    private let viewModel: AskLocationViewModelType
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .black
        // Do any additional setup after loading the view.
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(viewModel: AskLocationViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: AskLocationViewController.typeName, bundle: Bundle(for: type(of: self)))
    }
}
