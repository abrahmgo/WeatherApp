//
//  NetworkCoreAPI.swift
//  NetoworkCore
//
//  Created by Andrés Bonilla Gómez on 11/10/24.
//

import Foundation

public struct NetworkCoreAPI {
    
    public static func setup(with config: NetworkCoreAPIConfigType.Type) {
        NetworkCoreAPIConfig.shared = NetworkCoreAPIConfig(config)
    }
}
