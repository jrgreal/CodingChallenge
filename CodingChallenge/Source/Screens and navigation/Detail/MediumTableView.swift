//
//  MediumTableView.swift
//  CodingChallenge
//
//  Created by Reginald on 20/09/2019.
//  Copyright © 2019 Reginald. All rights reserved.
//

import UIKit

class MediumTableView: UITableView {
    @IBOutlet private weak var artworkImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var genreLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    var viewModel = ViewModel() {
        didSet {
            artworkImageView.image = viewModel.artwork
            nameLabel.text = viewModel.name
            genreLabel.text = viewModel.genre
            priceLabel.text = viewModel.price
            descriptionLabel.text = viewModel.description
        }
    }
}

extension MediumTableView {
    struct ViewModel {
        var artwork = UIImage()
        var name = ""
        var genre = ""
        var price = ""
        var description = ""
    }
}

extension MediumTableView.ViewModel {
    init(medium: Medium) {
        artwork = medium.artwork100.fetchedValue ?? #imageLiteral(resourceName: "placeholder")
        name = medium.trackName ?? ""
        genre = medium.primaryGenre
        price = "\(medium.trackPrice ?? 0) \(medium.currency)"
        description = medium.longDescription ?? "No description available."
    }
}
