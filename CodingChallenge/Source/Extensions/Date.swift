//
//  Date.swift
//  CodingChallenge
//
//  Created by Reginald on 22/09/2019.
//  Copyright © 2019 Reginald. All rights reserved.
//

import Foundation

extension Date {
    var dateText: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        let formatted = formatter.string(from: self)
        return formatted
    }
}
