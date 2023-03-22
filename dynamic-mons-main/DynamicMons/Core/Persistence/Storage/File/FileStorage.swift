//
//  FileStorage.swift
//  DynamicMons
//
//  Created by Mateus Lino on 16/12/22.
//

import Foundation

final class FileStorage: Storage {
    private let fileManager: FileManagerProtocol
    private let cacheURL: URL
    private let folderName: String

    init(fileManager: FileManagerProtocol, folderName: String = "com.leezy.DynamicMons.cache") {
        self.fileManager = fileManager
        self.folderName = folderName
        self.cacheURL = fileManager.urls(for: .cachesDirectory, in: .userDomainMask)[0]
    }

    func getData(forKey key: String) throws -> Data? {
        return fileManager.contents(atPath: url(for: key).path)
    }

    func write(data: Data, forKey key: String) throws {
        let folderURL = folderURL()
        if !fileManager.fileExists(atPath: folderURL.path) {
            try fileManager.createDirectory(at: folderURL, withIntermediateDirectories: true, attributes: nil)
        }
        try data.write(to: url(for: key))
    }

    func deleteData(forKey key: String) throws {
        let url = url(for: key)
        try fileManager.removeItem(at: url)
    }
}

extension FileStorage {
    func folderURL() -> URL {
        return cacheURL.appendingPathComponent(folderName)
    }

    func url(for key: String) -> URL {
        let key = key.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? key
        return cacheURL.appendingPathComponent(folderName, isDirectory: true).appendingPathComponent(key, isDirectory: false)
    }
}
