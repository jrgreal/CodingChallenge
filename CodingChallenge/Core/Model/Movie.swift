//
//  Movie.swift
//  CodingChallenge
//
//  Created by Reginald on 12/09/2019.
//  Copyright © 2019 Reginald. All rights reserved.
//

import Foundation
import UIKit

struct Movie {
    let trackId: Int
    let trackName: String
    let trackPrice: Double?
    let trackRentalPrice: Double?
    let trackHDPrice: Double?
    let trackHDRentalPrice: Double?
    let currency: String
    let primaryGenre: String
    let longDescription: String
    var artwork: FetchableValue<UIImage>
}

extension Movie: Codable {
    enum CodingKeys: String, CodingKey {
        case trackId
        case trackName
        case trackPrice
        case trackRentalPrice
        case trackHDPrice = "trackHdPrice"
        case trackHDRentalPrice = "trackHdRentalPrice"
        case currency
        case primaryGenre = "primaryGenreName"
        case longDescription
        case artwork = "artworkUrl100"
    }
}
