//
//  Decoding.swift
//  CodingChallenge
//
//  Created by Reginald on 12/09/2019.
//  Copyright © 2019 Reginald. All rights reserved.
//

import Foundation

extension KeyedDecodingContainer {
    func value<T>(forKey key: KeyedDecodingContainer.Key) throws -> T where T: Decodable {
        return try decode(T.self, forKey: key)
    }
}

extension URL {
    init?(template: String) {
        let regex = "\\{.*\\}"
        let cleanedString = template.replacingOccurrences(of: regex, with: "", options: .regularExpression)
        self.init(string: cleanedString)
    }
}
