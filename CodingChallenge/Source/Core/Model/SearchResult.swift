//
//  SearchResult.swift
//  CodingChallenge
//
//  Created by Reginald on 12/09/2019.
//  Copyright © 2019 Reginald. All rights reserved.
//

import Foundation

struct SearchResult {
    let count: Int
    let tracks: [Track]
}

extension SearchResult {
    enum CodingKeys: String, CodingKey {
        case count = "resultCount"
        case tracks = "results"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        count = try container.value(forKey: .count)
        tracks = try container.value(forKey: .tracks)
    }
}
