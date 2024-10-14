//
//  SplashViewController.swift
//  Weather
//
//  Created by Andrés Bonilla Gómez on 14/10/24.
//

import UIKit
import Utils
import Combine

class SplashViewController: UIViewController {
    
    private let coordinator: SplashCoordinator
    private let viewModel: SplashViewModelType
    private var cancellable: Set<AnyCancellable> = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .black
        bind()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(coordinator: SplashCoordinator,
         viewModel: SplashViewModelType) {
        self.coordinator = coordinator
        self.viewModel = viewModel
        super.init(nibName: SplashViewController.typeName, bundle: Bundle(for: type(of: self)))
    }
    
    func bind() {
        viewModel.outputs.goTo
            .receive(on: DispatchQueue.main)
            .sink { [weak self] path in
                switch path {
                case .app:
                    self?.coordinator.goToApp()
                case .tutorial:
                    self?.coordinator.goToTutorial()
                }
            }.store(in: &cancellable)
    }
}
