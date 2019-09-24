//
//  Log.swift
//  CodingChallenge
//
//  Created by Reginald on 24/09/2019.
//  Copyright © 2019 Reginald. All rights reserved.
//

import Foundation

struct Log {
    static func setLastVisitDate() {
        UserDefaults.standard.set(Date(), forKey: Keys.lastVisitDateKey)
    }
    static func getLastVisitDate() -> Date? {
        return UserDefaults.standard.object(forKey: Keys.lastVisitDateKey) as? Date
    }
}

extension Log {
    struct Keys {
        static let lastVisitDateKey = "lastVisitDate"
    }
}
