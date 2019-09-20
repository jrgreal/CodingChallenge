//
//  MediumCell.swift
//  CodingChallenge
//
//  Created by Reginald on 12/09/2019.
//  Copyright © 2019 Reginald. All rights reserved.
//

import UIKit

class MediumCell: UITableViewCell {
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

extension MediumCell: ImagedCell {
    override var imageView: UIImageView {
        return artworkImageView
    }
}

// MARK: - ViewModel
extension MediumCell {
    struct ViewModel {
        var artwork = UIImage()
        var name = ""
        var genre = ""
        var price = ""
    }
}
