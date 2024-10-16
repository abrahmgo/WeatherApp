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
import Localizable

protocol ShowWeatherDelegate: AnyObject {
    func add(coordinates: CLLocation)
    func cancel()
}

class ShowWeatherViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(cellType: IconTableViewCell.self, bundle: Bundle(for: IconTableViewCell.self))
            tableView.register(cellType: TitleTableViewCell.self, bundle: Bundle(for: TitleTableViewCell.self))
            tableView.register(cellType: TitleNumberTableViewCell.self, bundle: Bundle(for: TitleNumberTableViewCell.self))
            tableView.register(cellType: InformationTableViewCell.self, bundle: Bundle(for: InformationTableViewCell.self))
            tableView.register(cellType: SpaceTableViewCell.self, bundle: Bundle(for: SpaceTableViewCell.self))
            tableView.register(cellType: FooterTableViewCell.self, bundle: Bundle(for: FooterTableViewCell.self))
        }
    }
    
    var notificationButton: UIBarButtonItem?
    
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
        tableView.delegate = self
        setBind()
        tableView.backgroundColor = .clear
        view.layer.contents = #imageLiteral(resourceName: "weatherBackground").cgImage
        setupBarButtons()
    }
    
    private func setupBarButtons() {
        let rightButton = UIBarButtonItem(title: WeatherLanguage.btnAdd, image: nil,
                                          target: self, action: #selector(addFavorite))
        let leftButton = UIBarButtonItem(title: WeatherLanguage.btnReady, image: nil,
                                         target: self, action: #selector(cancel))
        
        notificationButton = UIBarButtonItem(image: UIImage(systemName: "bell"),
                                             style: .plain, target: self, action: #selector(pressNotification))
        
        let featureUse = viewModel.outputs.featureUse()
        switch featureUse {
        case .add:
            navigationItem.setRightBarButton(rightButton, animated: true)
            navigationItem.setLeftBarButton(leftButton, animated: true)
        case .location:
            navigationItem.setLeftBarButton(leftButton, animated: true)
        case .read:
            navigationItem.setLeftBarButton(leftButton, animated: true)
            navigationItem.setRightBarButton(notificationButton, animated: true)
        }
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
    
    @objc func pressNotification() {
        viewModel.inputs.pressNotification()
    }
    
    func setBind() {
        viewModel.outputs.components
            .receive(on: DispatchQueue.main)
            .sink { _ in } receiveValue: { [weak self] components in
                self?.components = components
                self?.tableView.reloadData()
            }.store(in: &cancellable)
        
        viewModel.outputs.isNotificationActive
            .receive(on: DispatchQueue.main)
            .sink { [weak self] value in
                guard let self = self, viewModel.outputs.featureUse() == .read else { return }
                let imageName = value ? "bell.fill" : "bell"
                self.notificationButton = UIBarButtonItem(image: UIImage(systemName: imageName),
                                                          style: .plain,
                                                          target: self,
                                                          action: #selector(self.pressNotification))
                self.navigationItem.setRightBarButton(self.notificationButton, animated: true)
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
        case .icon(let data):
            let cell = tableView.dequeueReusableCell(with: IconTableViewCell.self, for: indexPath)
            cell.update(model: data)
            return cell
        case .footer(let data):
            let cell = tableView.dequeueReusableCell(with: FooterTableViewCell.self, for: indexPath)
            cell.update(model: data)
            return cell
        }
    }
}

extension ShowWeatherViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
