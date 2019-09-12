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
    let id: Int?
    let name: String?
    let price: Decimal?
    let currency: String
    let primaryGenre: String
    let genres: [String]?
    let shortDescription: String?
    let longDescription: String?
    let artwork: FetchableValue<UIImage>
}

extension Track: Decodable {
    enum CodingKeys: String, CodingKey {
        case id = "trackId"
        case name = "trackName"
        case price = "trackPrice"
        case currency
        case primaryGenre = "primaryGenreName"
        case genres
        case shortDescription
        case longDescription
        case artwork = "artworkUrl60"
    }
}
