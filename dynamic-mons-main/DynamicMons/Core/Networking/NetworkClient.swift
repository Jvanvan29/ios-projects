//
//  NetworkClient.swift
//  DynamicMons
//
//  Created by Mateus Lino on 10/12/22.
//

import Combine
import Foundation

protocol NetworkClientProtocol {
    func execute<T: Decodable>(request: DataRequest) -> AnyPublisher<T, NetworkError>
    func signIn<T: Decodable>() -> AnyPublisher<T, NetworkError>
}

final class NetworkClient: NetworkClientProtocol {
    private let retries = 2
    private let dataRequestBuilder: DataRequestBuilderProtocol

    init(dataRequestBuilder: DataRequestBuilderProtocol) {
        self.dataRequestBuilder = dataRequestBuilder
    }

    func execute<T: Decodable>(request: DataRequest) -> AnyPublisher<T, NetworkError> {
        return dataRequestBuilder.dataRequest(request: request)
            .eraseToAnyGenericPublisher(withRetries: retries)
    }

    func signIn<T: Decodable>() -> AnyPublisher<T, NetworkError> {
        return dataRequestBuilder.signIn()
            .eraseToAnyGenericPublisher(withRetries: retries)
    }
}

fileprivate extension Publisher where Output == Data {
    func eraseToAnyGenericPublisher<T: Decodable>(withRetries retries: Int) -> AnyPublisher<T, NetworkError> {
        return retry(retries)
            .tryMap { data in
                return try JSONDecoder().decode(T.self, from: data)
            }
            .mapErrorToNetworkError()
            .eraseToAnyPublisher()
    }
}

fileprivate extension Publisher {
    func mapErrorToNetworkError() -> Publishers.MapError<Self, NetworkError> {
        return mapError { error in
            return error as? NetworkError ?? NetworkError(error: error)
        }
    }
}
