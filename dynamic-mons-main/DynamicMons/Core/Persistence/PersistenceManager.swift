//
//  PersistenceManager.swift
//  DynamicMons
//
//  Created by Mateus Lino on 16/12/22.
//

import Combine
import Foundation

protocol PersistenceManagerProtocol {
    func retrieve<T: Codable>(_ key: String, storageType: StorageType) -> T?
    func retrieve<T: Codable>(_ key: String, storageType: StorageType) -> AnyPublisher<T?, Never>
    func persist<T: Codable>(_ value: T?, key: String, storageType: StorageType)
    func clear(_ key: String, storageType: StorageType)
}

final class PersistenceManager: PersistenceManagerProtocol {
    private let keychain: KeychainProtocol
    private let userDefaults: UserDefaultsProtocol
    private let fileManager: FileManagerProtocol
    private let managerQueue = DispatchQueue(label: "com.leezy.DynamicMons.persistence", qos: .userInitiated)

    public init(keychain: KeychainProtocol = Keychain(), userDefaults: UserDefaultsProtocol = UserDefaults.standard, fileManager: FileManagerProtocol = FileManager()) {
        self.keychain = keychain
        self.userDefaults = userDefaults
        self.fileManager = fileManager
    }

    func retrieve<T: Codable>(_ key: String, storageType: StorageType) -> T? {
        let storage = storage(ofType: storageType)
        let data = try? storage.getData(forKey: key)
        return try? decode(data: data)
    }

    private func decode<T: Codable>(data: Data?) throws -> T? {
        guard let data = data else { return nil }
        return try JSONDecoder().decode(T.self, from: data)
    }

    private func storage(ofType type: StorageType) -> Storage {
        switch type {
        case .file:
            return FileStorage(fileManager: fileManager)
        case .sensitive:
            return KeychainStorage(keychain: keychain)
        case .userDefaults:
            return UserDefaultStorage(userDefaults: userDefaults)
        }
    }

    func retrieve<T: Codable>(_ key: String, storageType: StorageType) -> AnyPublisher<T?, Never> {
        let value: T? = retrieve(key, storageType: storageType)
        return Just(value)
            .receive(on: managerQueue)
            .eraseToAnyPublisher()
    }

    func persist<T: Codable>(_ value: T?, key: String, storageType: StorageType) {
        let persist = {
            let storage = self.storage(ofType: storageType)
            guard let value = value, let data = try? JSONEncoder().encode(value) else {
                self.clear(key, storageType: storageType)
                return
            }
            try? storage.write(data: data, forKey: key)
        }
        switch storageType {
        case .sensitive, .userDefaults:
            persist()
        case .file:
            managerQueue.async(execute: persist)
        }
    }

    func clear(_ key: String, storageType: StorageType) {
        let storage = storage(ofType: storageType)
        try? storage.deleteData(forKey: key)
    }
}
