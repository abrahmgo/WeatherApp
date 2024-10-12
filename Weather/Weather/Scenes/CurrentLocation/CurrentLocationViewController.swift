//
//  CurrentLocationViewController.swift
//  Weather
//
//  Created by Andrés Bonilla Gómez on 11/10/24.
//

import UIKit
import Utils
import WeatherUI
import Combine

class CurrentLocationViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(cellType: TitleTableViewCell.self, bundle: Bundle(for: TitleTableViewCell.self))
        }
    }
    
    private let viewModel: CurrentLocationViewModelType
    private var cancellable: Set<AnyCancellable> = Set<AnyCancellable>()
    private var components: [CurrentLocationComponents] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public init(viewModel: CurrentLocationViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: CurrentLocationViewController.typeName, bundle: Bundle(for: type(of: self)))
    }
    
    public func setup() {
        tableView.dataSource = self
        setBind()
    }
    
    func setBind() {
        viewModel.outputs.components
            .receive(on: DispatchQueue.main)
            .sink { _ in } receiveValue: { [weak self] components in
                self?.components = components
                self?.tableView.reloadData()
            }.store(in: &cancellable)
    }
}

extension CurrentLocationViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        components.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let component = components[indexPath.row]
        switch component {
        case .headerTitle(let data):
            let cell = tableView.dequeueReusableCell(with: TitleTableViewCell.self, for: indexPath)
            cell.update(model: data)
            return cell
        }
    }
}
