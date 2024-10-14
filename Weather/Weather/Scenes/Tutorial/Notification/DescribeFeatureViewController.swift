//
//  DescribeFeatureViewController.swift
//  Weather
//
//  Created by Andrés Bonilla Gómez on 13/10/24.
//

import UIKit
import Utils

class DescribeFeatureViewController: UIViewController {

    @IBOutlet weak var btnGoWeather: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        // Do any additional setup after loading the view.
    }


    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init() {
        super.init(nibName: DescribeFeatureViewController.typeName, bundle: Bundle(for: type(of: self)))
    }
    
    @IBAction func goWeather(_ sender: UIButton) {
        ListWeatherCoordinator().start()
    }
}
