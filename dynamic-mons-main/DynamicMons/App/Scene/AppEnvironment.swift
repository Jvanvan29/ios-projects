//
//  AppEnvironment.swift
//  DynamicMons
//
//  Created by Mateus Lino on 10/12/22.
//

import Foundation
import ComposableArchitecture

struct AppEnvironment {
    let healthManager: HealthManagerProtocol
    let imageCacheManager: ImageCacheManagerProtocol
    let localDatabase: LocalDatabaseProtocol
    let networkClient: NetworkClientProtocol
    let persistenceManager: PersistenceManagerProtocol
    let mainQueue: AnySchedulerOf<DispatchQueue>
}
