//
//  ModelTypes.swift
//  CodingChallenge
//
//  Created by Reginald on 12/09/2019.
//  Copyright © 2019 Reginald. All rights reserved.
//

import Foundation

struct ID<T>: Equatable {
    let value: Int
}

extension ID: Decodable {
    init(from decoder: Decoder) throws {
        let value = try decoder.singleValueContainer().decode(Int.self)
        self.init(value: value)
    }
}

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

extension FetchableValue: Decodable {
    init(from decoder: Decoder) throws {
        let template = try decoder.singleValueContainer().decode(String.self)
        guard let url = URL(template: template) else {
            throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: [], debugDescription: ""))
        }
        self.url = url
        value = .notFetched
    }
}
