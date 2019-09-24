//
//  NSCoder.swift
//  CodingChallenge
//
//  Created by Reginald on 24/09/2019.
//  Copyright © 2019 Reginald. All rights reserved.
//

import Foundation

extension NSCoder {
    func encode<T: Encodable>(_ object: T) {
        guard let data = try? JSONEncoder().encode(object) else {
            return
        }
        encode(data)
    }
    
    func decode<T: Decodable>() -> T? {
        guard let data = decodeObject() as? Data,
            let object = try? JSONDecoder().decode(T.self, from: data) else {
                return nil
        }
        return object
    }
}
