//
//  Medium.swift
//  CodingChallenge
//
//  Created by Reginald on 12/09/2019.
//  Copyright © 2019 Reginald. All rights reserved.
//

import Foundation
import UIKit

struct Medium {
    let trackId: Int?
    let trackName: String?
    let trackPrice: Double?
    let currency: String
    let primaryGenre: String
    let genres: [String]?
    let shortDescription: String?
    let longDescription: String?
    var artwork60: FetchableValue<UIImage>
    var artwork100: FetchableValue<UIImage>
}

extension Medium: Codable {
    enum CodingKeys: String, CodingKey {
        case trackId
        case trackName
        case trackPrice
        case currency
        case primaryGenre = "primaryGenreName"
        case genres
        case shortDescription
        case longDescription
        case artwork60 = "artworkUrl60"
        case artwork100 = "artworkUrl100"
    }
}
