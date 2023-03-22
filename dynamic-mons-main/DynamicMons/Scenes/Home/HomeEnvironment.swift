//
//  HomeEnvironment.swift
//  DynamicMons
//
//  Created by Mateus Lino on 10/12/22.
//

import Foundation
import ComposableArchitecture

struct HomeEnvironment {
    static let preview = HomeEnvironment(healthManager: HealthManager(), imageCacheManager: ImageCacheManager(), localDatabase: LocalDatabase(), persistenceManager: PersistenceManager(), mainQueue: .main)

    let healthManager: HealthManagerProtocol
    let imageCacheManager: ImageCacheManagerProtocol
    let localDatabase: LocalDatabaseProtocol
    let persistenceManager: PersistenceManagerProtocol
    let mainQueue: AnySchedulerOf<DispatchQueue>
}
