//
//  ChooseMonEnvironment.swift
//  DynamicMons
//
//  Created by Mateus Lino on 10/12/22.
//

import Foundation
import ComposableArchitecture

struct ChooseMonEnvironment {
    static let preview = ChooseMonEnvironment(localDatabase: LocalDatabase(), networkClient: NetworkClient(dataRequestBuilder: DataRequestBuilder()), persistenceManager: PersistenceManager(), mainQueue: .main)

    let localDatabase: LocalDatabaseProtocol
    let networkClient: NetworkClientProtocol
    let persistenceManager: PersistenceManagerProtocol
    let mainQueue: AnySchedulerOf<DispatchQueue>
}
