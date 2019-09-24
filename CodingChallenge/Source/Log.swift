//
//  Log.swift
//  CodingChallenge
//
//  Created by Reginald on 24/09/2019.
//  Copyright © 2019 Reginald. All rights reserved.
//

import Foundation

struct Log {
    private static let lastVisitDateKey = "lastVisitDate"
    
    static func setLastVisitDate() {
        UserDefaults.standard.set(Date(), forKey: lastVisitDateKey)
    }
    static func getLastVisitDate() -> Date? {
        return UserDefaults.standard.object(forKey: lastVisitDateKey) as? Date
    }
}
