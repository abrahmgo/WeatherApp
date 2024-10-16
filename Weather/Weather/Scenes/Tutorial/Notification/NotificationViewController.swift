//
//  DescribeFeatureViewController.swift
//  Weather
//
//  Created by Andrés Bonilla Gómez on 13/10/24.
//

import UIKit
import Utils
import Localizable

class NotificationViewController: UIViewController {

    @IBOutlet weak var btnGoWeather: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblMessage: UILabel!
    
    private let viewModel: NotificationViewModelType
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        localize()
    }


    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(viewModel: NotificationViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: NotificationViewController.typeName, bundle: Bundle(for: type(of: self)))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.inputs.requestAuthNotification()
    }
    
    @IBAction func goWeather(_ sender: UIButton) {
        ListWeatherCoordinator().start()
    }
    
    func localize() {
        lblTitle.text = WeatherLanguage.notificationViewTitle
        lblMessage.text = WeatherLanguage.notificationMessage
        btnGoWeather.setTitle(WeatherLanguage.notificationBtn, for: .normal)
    }
}
