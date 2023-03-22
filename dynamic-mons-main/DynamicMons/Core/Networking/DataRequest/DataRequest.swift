//
//  DataRequest.swift
//  DynamicMons
//
//  Created by Mateus Lino on 10/12/22.
//

import Foundation

protocol DataRequest {
    var route: String { get }
    var documentID: String? { get }
    var method: HTTPMethod { get }
    var parameters: Parameters? { get }
}

extension DataRequest {
    var documentID: String? {
        return nil
    }

    var parameters: Parameters? {
        return nil
    }
}
