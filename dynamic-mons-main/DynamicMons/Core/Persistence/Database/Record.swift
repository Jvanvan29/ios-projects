//
//  Record.swift
//  DynamicMons
//
//  Created by Mateus Lino on 16/12/22.
//

import Foundation
import GRDB

protocol Record: Codable, FetchableRecord, PersistableRecord {
    var id: Int64? { get set }
    static func createTable(using database: DatabaseProtocol, completion: (() -> Void)?) throws
}

protocol FetchableRecord: GRDB.FetchableRecord {}

protocol PersistableRecord: GRDB.PersistableRecord {}
