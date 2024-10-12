//
//  CurrentLocationViewModel.swift
//  Weather
//
//  Created by Andrés Bonilla Gómez on 12/10/24.
//

import Combine
import WeatherUI

class CurrentLocationViewModel: CurrentLocationViewModelType, CurrentLocationViewModelInputs, CurrentLocationViewModelOutputs {

    // MARK: Properties
    var outputs: CurrentLocationViewModelOutputs { return self }
    var inputs: CurrentLocationViewModelInputs { return self }
    
    // MARK: Outputs
    var components: CurrentValueSubject<[CurrentLocationComponents], Never> = CurrentValueSubject([])
    var isLoading: CurrentValueSubject<Bool, Never> = CurrentValueSubject(false)
    var error: PassthroughSubject<Error, Never> = PassthroughSubject()
    
    
    // MARK: Private
    private let dependencies: CurrentLocationDependencies
    private var cancellable: Set<AnyCancellable> = Set<AnyCancellable>()
    
    public init(dependencies: CurrentLocationDependencies) {
        self.dependencies = dependencies
        
        setComponents()
    }
    
    private func setComponents() {
        binds()
        getLocation()
    }
    
    private func getLocation() {
        Task {
            do {
                try await dependencies.startLocation.execute(type: .always)
            } catch {
                
            }
        }
    }
    
    private func binds() {
        dependencies.getCurrentLocation.execute()
            .sink(receiveCompletion: { _ in}) { location in
                Task {
                    do {
                        let address = try await self.dependencies.getAddressByCoordinates.execute(coordinates: location.coordinate)
                        let titleData = TitleTableViewCellData(title: "Mi Ubicacion", 
                                                               subtitle: address.city + " " + address.state)
                        let component = CurrentLocationComponents.headerTitle(data: titleData)
                        self.components.send([component])
                    } catch {
                        
                    }
                }
            }.store(in: &cancellable)
    }
}
