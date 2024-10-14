//
//  ListWeatherViewController.swift
//  Weather
//
//  Created by Andrés Bonilla Gómez on 12/10/24.
//

import UIKit
import Combine
import Utils
import CoreLocation
import WeatherEntities
import WeatherUI

class ListWeatherViewController: UIViewController {
    
    var resultSearchController: UISearchController? = nil
    private let refreshControl = UIRefreshControl()
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(cellType: CityWeatherTableViewCell.self, bundle: Bundle(for: CityWeatherTableViewCell.self))
            tableView.dataSource = self
            tableView.delegate = self
        }
    }
    
    private let coordinator: ListWeatherCoordinator
    private let viewModel: ListWeatherViewModelType
    private var cancellable: Set<AnyCancellable> = Set<AnyCancellable>()
    
    private var components: [ListWeatherComponent] = []
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(coordinator: ListWeatherCoordinator,
         viewModel: ListWeatherViewModelType) {
        self.coordinator = coordinator
        self.viewModel = viewModel
        super.init(nibName: ListWeatherViewController.typeName, bundle: Bundle(for: type(of: self)))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        setupRefresh()
        setupBindings()
        localize()
    }
    
    private func setup() {
        view.backgroundColor = .black
        tableView.backgroundColor = .clear
        title = "Clima"
        let locationSearchTable = AddressSearchTableViewController()
        locationSearchTable.delegate = self
        resultSearchController = UISearchController(searchResultsController: locationSearchTable)
        resultSearchController?.searchResultsUpdater = locationSearchTable
        let searchBar = resultSearchController!.searchBar
        searchBar.sizeToFit()
        searchBar.placeholder = "Buscar Ciudad"
        searchBar.searchBarStyle = .minimal
        searchBar.setValue("Cancelar", forKey: "cancelButtonText")
        let textfield = searchBar.searchTextField
        textfield.backgroundColor = .white
        navigationItem.searchController = resultSearchController
        resultSearchController?.hidesNavigationBarDuringPresentation = false
        resultSearchController?.obscuresBackgroundDuringPresentation = true
        definesPresentationContext = true
    }
    
    private func setupRefresh() {
        
        tableView.refreshControl = refreshControl
        refreshControl.tintColor = UIColor(red:0.25, green:0.72, blue:0.85, alpha:1.0)
        refreshControl.attributedTitle = NSAttributedString(string: "Actualizando información ...",
                                                            attributes: [:])
        refreshControl.addTarget(self, action: #selector(refreshWeatherData(_:)), for: .valueChanged)
    }
    
    @objc private func refreshWeatherData(_ sender: Any) {
        viewModel.inputs.initFeature()
    }
    
    private func setupBindings() {
        
        viewModel.outputs.components
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] components in
                self?.components = components
                self?.refreshControl.endRefreshing()
                self?.tableView.reloadData()
            }).store(in: &cancellable)
    }
    
    private func localize() { }
}

// MARK: - UITableViewDataSource

extension ListWeatherViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return components.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let component = components[indexPath.row]
        switch component {
        case .city(let data):
            let cell = tableView.dequeueReusableCell(with: CityWeatherTableViewCell.self, for: indexPath)
            cell.update(model: data)
            return cell
        }
    }
}

// MARK: - UITableViewDelegate

extension ListWeatherViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        let weather = viewModel.outputs.getWeather(index: indexPath.row)
        let featureUse = viewModel.outputs.featureUse(index: indexPath.row)
        coordinator.presentWeather(localWeather: weather, featureUse: featureUse)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.inputs.deleteCity(index: indexPath.row)
        }
    }
    
    public func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        let isLocal = viewModel.outputs.featureUse(index: indexPath.row)
        switch isLocal {
        case .location:
            return .none
        default:
            return .delete
        }
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Eliminar"
    }
}

extension ListWeatherViewController: AddressSearchTableViewDelegate {
    
    func selectLocation(location: CLLocationCoordinate2D) {
        resultSearchController?.dismiss(animated: true)
        resultSearchController?.searchBar.text = nil
        let coordinates = CLLocation(latitude: location.latitude, longitude: location.longitude)
        let weather = LocalWeather(id: 0, latitude: location.latitude, longitude: location.longitude)
        let featureUse = viewModel.outputs.featureUse(location: coordinates)
        coordinator.presentWeather(localWeather: weather, featureUse: featureUse)
    }
}

extension ListWeatherViewController: ShowWeatherDelegate {
    
    func add(coordinates: CLLocation) {
        viewModel.inputs.addNewCity(location: coordinates)
    }
    
    func cancel() {
        viewModel.inputs.updateDB()
    }
}
