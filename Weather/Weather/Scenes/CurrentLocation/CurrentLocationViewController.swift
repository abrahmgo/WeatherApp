//
//  CurrentLocationViewController.swift
//  Weather
//
//  Created by Andrés Bonilla Gómez on 11/10/24.
//

import UIKit
import Utils
import WeatherUsecases
import WeatherCore
import Combine
import WeatherEntities

class CurrentLocationViewController: UIViewController {

    private let startLocation: StarLocalizationUseCaseType
    private let getCurrentLocation: GetCurrentLocationUseCaseType
    private var cancellable: Set<AnyCancellable> = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        binds()
        Task {
            try await Task.sleep(for: .seconds(2))
            try await startLocation.execute(type: .always)
        }
        // Do any additional setup after loading the view.
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public init() {
        let locationService = WeatherLocalDataSource.location
        startLocation = StarLocalizationUseCase(locationService: locationService)
        getCurrentLocation = GetCurrentLocationUseCase(locationService: locationService)
        super.init(nibName: CurrentLocationViewController.typeName, bundle: Bundle(for: type(of: self)))
    }
    
    private func binds() {
        getCurrentLocation.execute()
            .sink(receiveCompletion: { result in
                dump(result)
            }) { location in
                dump(location.coordinate)
                Task {
                    let remote = WeatherCore.WeatherRemoteDataSource.weather
                    let usecase = GetWeatherUsecase(remoteDataSource: remote)
                    let model = WeatherCoordinates(latitude: location.coordinate.latitude.magnitude,
                                                   longitude: location.coordinate.longitude.magnitude)
                    let info = try await usecase.execute(coordinates: model)
                    dump(info)
                }
            }.store(in: &cancellable)
    }
}
