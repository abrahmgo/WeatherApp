//
//  AskLocationViewController.swift
//  Weather
//
//  Created by Andrés Bonilla Gómez on 13/10/24.
//

import UIKit
import Utils
import Localizable

class AskLocationViewController: UIViewController {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblMessage: UILabel!
    
    private let viewModel: AskLocationViewModelType
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .black
        localize()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(viewModel: AskLocationViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: AskLocationViewController.typeName, bundle: Bundle(for: type(of: self)))
    }
    
    func localize() {
        lblTitle.text = WeatherLanguage.localizationTitle
        lblMessage.text = WeatherLanguage.localizationMessage
    }
}
