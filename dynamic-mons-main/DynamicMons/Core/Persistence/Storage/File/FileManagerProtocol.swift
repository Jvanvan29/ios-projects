//
//  FileManagerProtocol.swift
//  DynamicMons
//
//  Created by Mateus Lino on 16/12/22.
//

import Foundation

protocol FileManagerProtocol {
    func urls(for directory: FileManager.SearchPathDirectory, in domainMask: FileManager.SearchPathDomainMask) -> [URL]
    func fileExists(atPath path: String) -> Bool
    func createDirectory(at url: URL, withIntermediateDirectories createIntermediates: Bool, attributes: [FileAttributeKey : Any]?) throws
    func contents(atPath path: String) -> Data?
    func removeItem(at URL: URL) throws
}

extension FileManager: FileManagerProtocol {}
