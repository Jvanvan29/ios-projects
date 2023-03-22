//
//  UserDefaultsProtocol.swift
//  DynamicMons
//
//  Created by Mateus Lino on 16/12/22.
//

import Foundation

public protocol UserDefaultsProtocol {
    func value(forKey key: String) -> Any?
    func set(_ value: Any?, forKey defaultName: String)
    func object(forKey defaultName: String) -> Any?
    func removeObject(forKey defaultName: String)
}

// MARK: - UserDefaults Conformance to UserDefaultsProtocol

extension UserDefaults: UserDefaultsProtocol {}
