//
//  Collection+Safe.swift
//  DynamicMons
//
//  Created by Mateus Lino on 11/12/22.
//

import Foundation

extension Collection {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
