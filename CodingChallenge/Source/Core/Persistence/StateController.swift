//
//  StateController.swift
//  CodingChallenge
//
//  Created by Reginald on 23/09/2019.
//  Copyright © 2019 Reginald. All rights reserved.
//

import Foundation

class StateController {
    private let lastVisitDateKey = "lastVisitDate"
    
    var lastVisitDate: Date? {
        return UserDefaults.standard.object(forKey: lastVisitDateKey) as? Date
    }
    
    func setLastVisitDate() {
        UserDefaults.standard.set(Date(), forKey: lastVisitDateKey)
    }
    
    
    func encode<T: Encodable>(_ object: T, forKey key: String, withCoder coder: NSCoder) {
        guard let data = try? JSONEncoder().encode(object) else {
            return
        }
        coder.encode(data, forKey: key)
    }
    
    func decode<T: Decodable>(forKey key: String, withCoder coder: NSCoder) -> T? {
        guard let data = coder.decodeObject(forKey: key) as? Data,
            let object = try? JSONDecoder().decode(T.self, from: data) else {
                return nil
        }
        return object
    }
}
