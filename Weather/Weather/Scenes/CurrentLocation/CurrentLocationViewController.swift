//
//  CurrentLocationViewController.swift
//  Weather
//
//  Created by Andrés Bonilla Gómez on 11/10/24.
//

import UIKit
import Utils
import WeatherUI

class CurrentLocationViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(cellType: TitleTableViewCell.self, bundle: Bundle(for: TitleTableViewCell.self))
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public init() {
        super.init(nibName: CurrentLocationViewController.typeName, bundle: Bundle(for: type(of: self)))
    }
    
    public func setup() {
        tableView.dataSource = self
    }
}

extension CurrentLocationViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: TitleTableViewCell.self, for: indexPath)
        return cell
    }
}
