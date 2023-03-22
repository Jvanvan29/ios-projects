//
//  NetworkError.swift
//  DynamicMons
//
//  Created by Mateus Lino on 10/12/22.
//

import Foundation

 class NetworkError: Error, LocalizedError, Equatable {
    let status: HTTPStatus
    let localizedDescription: String
    
     var code: Int { return status.rawValue }
    
     var errorDescription: String? {
        return "\(status)"
    }
    
    init(status: HTTPStatus) {
        self.status = status
        localizedDescription = String(describing: status)
            .replacingOccurrences(of: "(?<=[a-z])(?=[A-Z])|(?<=[A-Z])(?=[A-Z][a-z])", with: " ", options: .regularExpression)
            .capitalized
    }
    
    required init(error: Error) {
        if let networkError = error as? NetworkError {
            status = networkError.status
        } else {
            if let error = error as? URLError {
                status = HTTPStatus(rawValue: error.errorCode) ?? .unknown
            } else {
                status = .unknown
            }
        }
        self.localizedDescription = error.localizedDescription
    }
    
    static func == (lhs: NetworkError, rhs: NetworkError) -> Bool {
        return lhs.status == rhs.status
    }
}
