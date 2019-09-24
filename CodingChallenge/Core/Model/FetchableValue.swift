//
//  FetchableValue.swift
//  CodingChallenge
//
//  Created by Reginald on 23/09/2019.
//  Copyright © 2019 Reginald. All rights reserved.
//

import Foundation

struct FetchableValue<T> {
    let url: URL
    var value: RemoteValue<T>
    
    indirect enum RemoteValue<T> {
        case notFetched
        case fetched(value: T)
    }
    
    var fetchedValue: T? {
        if case let .fetched(value) = value {
            return value
        }
        return nil
    }
    
    mutating func update(newValue: T) {
        value = .fetched(value: newValue)
    }
}

extension FetchableValue: Codable {
    init(from decoder: Decoder) throws {
        let urlString = try decoder.singleValueContainer().decode(String.self)
        guard let url = URL(string: urlString) else {
            throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: [], debugDescription: ""))
        }
        self.url = url
        value = .notFetched
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(url.absoluteString)
    }
}
