//
//  Storage.swift
//  DynamicMons
//
//  Created by Mateus Lino on 16/12/22.
//

import Foundation

protocol Storage {
    func getData(forKey key: String) throws -> Data?
    func write(data: Data, forKey key: String) throws
    func deleteData(forKey key: String) throws
}
