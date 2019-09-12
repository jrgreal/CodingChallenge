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
    
    init(closure: () throws -> Wrapped) {
        do { self = .success(try closure()) }
        catch { self = .failure(error) }
    }
    
    func get() throws -> Wrapped {
        switch self {
        case let .success(value): return value
        case let .failure(error): throw error
        }
    }
}
