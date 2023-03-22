//
//  KeychainStorage.swift
//  DynamicMons
//
//  Created by Mateus Lino on 16/12/22.
//

import Foundation

final class KeychainStorage: Storage {
    private let keychain: KeychainProtocol

    init(keychain: KeychainProtocol) {
        self.keychain = keychain
    }

    func getData(forKey key: String) throws -> Data? {
        return try keychain.getData(forKey: key)
    }

    func write(data: Data, forKey key: String) throws {
        try keychain.setData(data, forKey: key)
    }

    func deleteData(forKey key: String) throws {
        try keychain.removeData(forKey: key)
    }
}
