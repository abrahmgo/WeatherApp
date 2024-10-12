//
//  ListWeatherViewController.swift
//  Weather
//
//  Created by Andrés Bonilla Gómez on 12/10/24.
//

import UIKit
import Combine

class ListWeatherViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.tableFooterView = UIView()
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
        setupBindings()
        localize()
    }
    
    private func setup() { 
        title = "Clima"
    }
    
    private func setupBindings() {
        
        viewModel.outputs.components
            .sink(receiveValue: { [weak self] components in
                self?.components = components
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
        // TODO: Should implement based on availabe components
        return UITableViewCell()
    }
}

// MARK: - UITableViewDelegate

extension ListWeatherViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
