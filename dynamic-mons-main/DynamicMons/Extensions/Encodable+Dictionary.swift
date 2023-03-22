//
//  Encodable+Dictionary.swift
//  DynamicMons
//
//  Created by Mateus Lino on 19/12/22.
//

import Foundation

extension Encodable {
    var dictionary: [String: Any] {
        guard let jsonData = try? JSONEncoder().encode(self),
              let dictionary = try? JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as? [String: Any] else {
            return [:]
        }
        return dictionary
    }
}
