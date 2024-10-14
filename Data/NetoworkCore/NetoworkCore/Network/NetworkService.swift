//
//  NetworkService.swift
//  NetoworkCore
//
//  Created by Andrés Bonilla Gómez on 11/10/24.
//

import Foundation

public protocol NetworkServiceType {
    func request<T: Decodable>(target: NetworkTargetType) async throws -> T
    func request(target: NetworkTargetType) async throws -> Data
}

struct NetworkService: NetworkServiceType {
    
    private let configuration: URLSessionConfiguration
    private let session: URLSession
    private let token: String
    private let baseURL: String
    private let language: String
    
    init(timeoutForRequest: TimeInterval = 20.0,
         baseURL: String,
         headers: [String: String] = [:],
         token: String,
         language: String) {
        self.token = token
        self.language = language
        self.baseURL = baseURL
        self.configuration = URLSessionConfiguration.default
        self.configuration.timeoutIntervalForRequest = timeoutForRequest
        self.configuration.httpAdditionalHeaders = headers
        self.session = URLSession(configuration: self.configuration)
    }
    
    func request(target: NetworkTargetType) async throws -> Data {
        guard let url = prepareURL(target: target) else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = target.method.rawValue
        request.allHTTPHeaderFields = target.headers
        request.httpBody = target.body
        
        return try await withCheckedThrowingContinuation { continuation in
            self.session.dataTask(with: request) { data, response, error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else if let data = data {
                    continuation.resume(returning: data)
                } else {
                    continuation.resume(throwing: NetworkError.checkRequest)
                }
            }.resume()
        }
    }
    
    func request<T>(target: NetworkTargetType) async throws -> T where T : Decodable {
        
        guard let url = prepareURL(target: target) else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = target.method.rawValue
        request.allHTTPHeaderFields = target.headers
        request.httpBody = target.body
        
        return try await withCheckedThrowingContinuation { continuation in
            self.session.dataTask(with: request) { data, response, error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else if let data = data {
                    if let decoded = try? JSONDecoder().decode(T.self, from: data) {
                        continuation.resume(returning: decoded)
                    } else {
                        continuation.resume(throwing: NetworkError.notDacodedData)
                    }
                } else {
                    continuation.resume(throwing: NetworkError.checkRequest)
                }
            }.resume()
        }
    }
    
    private func prepareURL(target: NetworkTargetType) -> URL? {
        var newBaseURL = ""
        if target.baseURL.isEmpty {
            newBaseURL =  baseURL + target.path
            var urlComponents = URLComponents(string: newBaseURL)
            let tokenQueryItem = [URLQueryItem(name: "appid", value: token),
                                  URLQueryItem(name: "lang", value: language)]
            let queryItems = target.queryParams?.map({ (key, value) in
                return URLQueryItem(name: key, value: String(describing: value) )
            })
            urlComponents?.queryItems = tokenQueryItem + (queryItems ?? [])
            return urlComponents?.url
        } else {
            newBaseURL = target.baseURL + target.path
            let url = URLComponents(string: newBaseURL)
            return url?.url
        }
    }
}
