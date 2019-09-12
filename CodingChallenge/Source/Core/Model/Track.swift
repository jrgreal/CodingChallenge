//
//  Track.swift
//  CodingChallenge
//
//  Created by Reginald on 12/09/2019.
//  Copyright © 2019 Reginald. All rights reserved.
//

import Foundation
import UIKit

struct Track {
    let id: UInt
    let name: String
    let price: Decimal
    let genre: String
    let shortDescription: String
    let longDescription: String
    let artwork: FetchableValue<UIImage>
}

extension Track: Decodable {
    enum CodingKeys: String, CodingKey {
        case id = "trackId"
        case name = "trackName"
        case price = "trackPrice"
        case genre = "primaryGenreName"
        case shortDescription
        case longDescription
        case artwork = "artworkUrl60"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.value(forKey: .id)
        name = try container.value(forKey: .name)
        price = try container.value(forKey: .price)
        genre = try container.value(forKey: .genre)
        shortDescription = try container.value(forKey: .shortDescription)
        longDescription = try container.value(forKey: .longDescription)
        artwork = try container.value(forKey: .artwork)
    }
}
