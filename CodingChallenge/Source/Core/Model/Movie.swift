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
    var artwork60: FetchableValue<UIImage>
    var artwork100: FetchableValue<UIImage>
}

//extension Movie {
//    enum Resolution {
//        case sd(buy: Double?, rent: Double?)
//        case hd(buy: Double?, rent: Double?)
//    }
//    
//    var pricesSD: [Double] {
//        return []
//    }
//    
//    var resolutions: [Resolution] {
//        return []
//    }
//}

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
        case artwork60 = "artworkUrl60"
        case artwork100 = "artworkUrl100"
    }
}
