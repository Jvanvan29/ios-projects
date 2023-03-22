//
//  DatabaseQueueProtocol.swift
//  DynamicMons
//
//  Created by Mateus Lino on 16/12/22.
//

import Combine
import Foundation
import GRDB
import SwiftUI

protocol LocalDatabaseProtocol {
    func createTable<T: Record>(ofType type: T.Type) -> AnyPublisher<Void, GenericError>
    func fetchAll<T: Record>(type: T.Type) -> AnyPublisher<[T], GenericError>
    func write<T: Record>(value: T) -> AnyPublisher<T, GenericError>
}

protocol DatabaseQueueProtocol: DatabaseQueue {}

protocol DatabaseProtocol: Database {}

final class LocalDatabase: LocalDatabaseProtocol {
    private let databaseQueue: DatabaseQueueProtocol

    init(databaseQueue: DatabaseQueueProtocol = try! DatabaseQueue()) {
        self.databaseQueue = databaseQueue
    }

    func createTable<T: Record>(ofType type: T.Type) -> AnyPublisher<Void, GenericError> {
        return Future { [unowned self] promise in
            do {
                try self.databaseQueue.write { database in
                    try type.createTable(using: database) {
                        promise(.success(()))
                    }
                }
            } catch {
                promise(.failure(GenericError()))
            }
        }
        .eraseToAnyPublisher()
    }

    func fetchAll<T: Record>(type: T.Type) -> AnyPublisher<[T], GenericError> {
        return Future { [unowned self] promise in
            do {
                try self.databaseQueue.read {
                    if try $0.tableExists(type.databaseTableName) {
                        let records = try type.fetchAll($0)
                        promise(.success(records))
                    } else {
                        promise(.success([]))
                    }
                }
            } catch {
                promise(.failure(GenericError()))
            }
        }
        .eraseToAnyPublisher()
    }

    func write<T: Record>(value: T) -> AnyPublisher<T, GenericError> {
        return Future { [unowned self] promise in
            do {
                try self.databaseQueue.write {
                    if try value.exists($0) {
                        try value.update($0)
                    } else {
                        try value.insert($0)
                    }
                    promise(.success(value))
                }
            } catch {
                promise(.failure(GenericError()))
            }
        }
        .eraseToAnyPublisher()
    }
}

extension DatabaseQueue: DatabaseQueueProtocol {}

extension Database: DatabaseProtocol {}
