//
//  UserDefaultStorage.swift
//  DynamicMons
//
//  Created by Mateus Lino on 16/12/22.
//

import Foundation

final class UserDefaultStorage: Storage {
    private let userDefaults: UserDefaultsProtocol

    init(userDefaults: UserDefaultsProtocol) {
        self.userDefaults = userDefaults
    }

    func getData(forKey key: String) throws -> Data? {
        return userDefaults.object(forKey: key) as? Data
    }

    func write(data: Data, forKey key: String) {
        self.userDefaults.set(data, forKey: key)
    }

    func deleteData(forKey key: String) {
        self.userDefaults.removeObject(forKey: key)
    }
}
