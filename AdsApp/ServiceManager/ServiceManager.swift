//
//  ServiceManager.swift
//  AdsApp
//
//  Created by Rida TOUKRICHTE on 09/01/2024.
//

import Foundation
import Combine

enum NetworkError: Error {
    case noConnectionInternet
    case serverError
    case badURL
    case decodingError
    case unknownError
    case requestFailed
}

final class ServiceManager {
    
    // MARK: - singleton instance
    static let shared = ServiceManager()
    
    private init() {}
    
    private var subscriptions = Set<AnyCancellable>()
    
    // MARK: - Generic Get method
    
    func fetch<T: Codable>(from endpoint: String) -> Future<T, NetworkError> {
        
        return Future { [unowned self] promise in
            
            guard let endpointURL = URL(string: endpoint) else {
                return promise(.failure(.badURL))
            }
            
            if Reachability.isConnectedToNetwork() {
                URLSession.shared.dataTaskPublisher(for: endpointURL)
                    .tryMap { (data, response) in
                        guard let httpResponse = response as? HTTPURLResponse
                        else {
                            throw NetworkError.requestFailed
                        }
                        
                        if (200...299 ~= httpResponse.statusCode) {
                            return data
                        }
                        else if (500...599 ~= httpResponse.statusCode) {
                            throw NetworkError.serverError
                        }
                        
                        throw NetworkError.unknownError
                    }
                    .decode(type: T.self, decoder: JSONDecoder())
                    .receive(on: DispatchQueue.main)
                    .sink { completion in
                        if case let .failure(error) = completion {
                            switch error {
                            case is URLError:
                                promise(.failure(.badURL))
                            case is DecodingError:
                                promise(.failure(.decodingError))
                            default:
                                promise(.failure(.unknownError))
                            }
                        }
                    } receiveValue: {
                        promise(.success($0))
                    }
                    .store(in: &subscriptions)
            }
            else{
                promise(.failure(.noConnectionInternet))
            }
        }
    }
}
