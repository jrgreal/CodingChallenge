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
    let media: [Movie]
}

extension SearchResult: Decodable {
    enum CodingKeys: String, CodingKey {
        case count = "resultCount"
        case media = "results"
    }
}
