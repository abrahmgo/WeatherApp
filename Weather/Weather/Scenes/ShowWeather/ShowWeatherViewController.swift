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
import CoreLocation

protocol ShowWeatherDelegate: AnyObject {
    func add(coordinates: CLLocation)
    func cancel()
}

class ShowWeatherViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(cellType: TitleTableViewCell.self, bundle: Bundle(for: TitleTableViewCell.self))
            tableView.register(cellType: TitleNumberTableViewCell.self, bundle: Bundle(for: TitleNumberTableViewCell.self))
            tableView.register(cellType: InformationTableViewCell.self, bundle: Bundle(for: InformationTableViewCell.self))
            tableView.register(cellType: SpaceTableViewCell.self, bundle: Bundle(for: SpaceTableViewCell.self))
        }
    }
    
    private let viewModel: ShowWeatherViewModelType
    private var cancellable: Set<AnyCancellable> = Set<AnyCancellable>()
    private var components: [ShowWeatherComponents] = []
    private weak var delegate: ShowWeatherDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public init(viewModel: ShowWeatherViewModelType,
                delegate: ShowWeatherDelegate? = nil) {
        self.viewModel = viewModel
        self.delegate = delegate
        super.init(nibName: ShowWeatherViewController.typeName, bundle: Bundle(for: type(of: self)))
    }
    
    public func setup() {
        tableView.dataSource = self
        setBind()
        
        guard !viewModel.outputs.isCurrentLocation() else {
            return
        }
        
        let rightButton = UIBarButtonItem(title: "Agregar", image: nil,
                                          target: self, action: #selector(addFavorite))
        navigationItem.setRightBarButton(rightButton, animated: true)
        
        let leftButton = UIBarButtonItem(title: "Cancelar", image: nil,
                                          target: self, action: #selector(cancel))
        navigationItem.setLeftBarButton(leftButton, animated: true)
    }
    
    @objc func addFavorite() {
        let coordinates = viewModel.outputs.getCoordinates()
        delegate?.add(coordinates: coordinates)
        dismiss(animated: true)
    }
    
    @objc func cancel() {
        delegate?.cancel()
        dismiss(animated: true)
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

extension ShowWeatherViewController: UITableViewDataSource {
    
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
        case .temperature(let data):
            let cell = tableView.dequeueReusableCell(with: TitleNumberTableViewCell.self, for: indexPath)
            cell.update(model: data)
            return cell
        case .information(let data):
            let cell = tableView.dequeueReusableCell(with: InformationTableViewCell.self, for: indexPath)
            cell.update(model: data)
            return cell
        case .space(let data):
            let cell = tableView.dequeueReusableCell(with: SpaceTableViewCell.self, for: indexPath)
            cell.update(model: data)
            return cell
        }
    }
}
