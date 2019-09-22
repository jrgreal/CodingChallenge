//
//  PersistenceController.swift
//  CodingChallenge
//
//  Created by Reginald on 22/09/2019.
//  Copyright © 2019 Reginald. All rights reserved.
//

import Foundation

class PersistenceController  {
    private let appDirectory: AppDirectory
    var fileManager: FileManaging = FileManager.default
    
    init(cachesDirectoryURL: URL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!) {
        appDirectory = AppDirectory(iOSPersistenceDirectoryURL: cachesDirectoryURL)
    }
}

// MARK: - AppDirectory
extension PersistenceController {
    struct AppDirectory {
        static let name = "appAPICache"
        let iOSPersistenceDirectoryURL: URL
        
        var baseURL: URL {
            return iOSPersistenceDirectoryURL.appendingPathComponent(AppDirectory.name)
        }
        
        static func value<V: Decodable>(from data: Data) -> V? {
            return try? JSONDecoder().decode(V.self, from: data)
        }
        
        func makeStorableData<V: Encodable>(value: V, url: URL) -> StorableData? {
            guard let data = try? JSONEncoder().encode(value),
                let fileURL = url.fileUrl(withBaseURL: baseURL) else {
                    return nil
            }
            return StorableData(data: data, fileURL: fileURL)
        }
    }
}

// MARK: StorableData
extension PersistenceController.AppDirectory {
    struct StorableData {
        let data: Data
        let fileURL: URL
    }
}
