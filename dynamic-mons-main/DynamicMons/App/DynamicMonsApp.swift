//
//  DynamicMonsApp.swift
//  DynamicMons
//
//  Created by Mateus Lino on 10/12/22.
//

import ComposableArchitecture
import GRDB
import SwiftUI

@main
struct DynamicMonsApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        let store = Store(
            initialState: .landing(LandingState()),
            reducer: appReducer,
            environment: AppEnvironment(
                healthManager: healthManager,
                imageCacheManager: imageCacheManager,
                localDatabase: try! createDatabaseIfNeeded(),
                networkClient: networkClient,
                persistenceManager: persistenceManager,
                mainQueue: .main
            )
        )
        WindowGroup {
            AppView(store: store)
        }
    }

    private let healthManager = HealthManager()

    private let imageCacheManager = ImageCacheManager()

    private var networkClient: NetworkClient {
        let dataRequestBuilder = DataRequestBuilder()
        return NetworkClient(dataRequestBuilder: dataRequestBuilder)
    }

    private let persistenceManager = PersistenceManager(keychain: Keychain())

    private func createDatabaseIfNeeded() throws -> LocalDatabaseProtocol {
        // Create a folder for storing the SQLite database, as well as
        // the various temporary files created during normal database
        // operations (https://sqlite.org/tempfiles.html).
        let fileManager = FileManager()
        let folderURL = try fileManager
            .url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            .appendingPathComponent("database", isDirectory: true)
        try fileManager.createDirectory(at: folderURL, withIntermediateDirectories: true)

        // Connect to a database on disk
        // See https://github.com/groue/GRDB.swift/blob/master/README.md#database-connections
        let databaseURL = folderURL.appendingPathComponent("db.sqlite")
        let databaseQueue = try DatabaseQueue(path: databaseURL.path)
        return LocalDatabase(databaseQueue: databaseQueue)
    }
}
