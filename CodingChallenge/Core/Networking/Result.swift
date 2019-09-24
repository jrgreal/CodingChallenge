//
//  Result.swift
//  CodingChallenge
//
//  Created by Reginald on 12/09/2019.
//  Copyright © 2019 Reginald. All rights reserved.
//

import Foundation

enum Result<Wrapped> {
    case failure(Error)
    case success(Wrapped)
    
    func get() throws -> Wrapped {
        switch self {
        case let .success(value): return value
        case let .failure(error): throw error
        }
    }
}
