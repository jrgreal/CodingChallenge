//
//  MediaCell.swift
//  CodingChallenge
//
//  Created by Reginald on 12/09/2019.
//  Copyright © 2019 Reginald. All rights reserved.
//

import UIKit

class MediaCell: UITableViewCell {
    @IBOutlet private weak var artworkImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var genreLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    
    var viewModel = ViewModel() {
        didSet {
            artworkImageView.image = viewModel.artwork
            nameLabel.text = viewModel.name
            genreLabel.text = viewModel.genre
            priceLabel.text = viewModel.price
        }
    }
}

// MARK: - ViewModel

extension MediaCell {
    struct ViewModel {
        var artwork = UIImage()
        var name = ""
        var genre = ""
        var price = ""
    }
}
