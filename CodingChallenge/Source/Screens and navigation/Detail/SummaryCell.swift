//
//  SummaryCell.swift
//  CodingChallenge
//
//  Created by Reginald on 20/09/2019.
//  Copyright © 2019 Reginald. All rights reserved.
//

import UIKit

class SummaryCell: MovieCell {}


    /*
class SummaryCell: UITableViewCell {
    @IBOutlet private weak var artworkImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var genreLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    
    @IBOutlet private weak var sdPriceView: UIView!
    @IBOutlet private weak var sdBuyPriceLabel: UILabel!
    @IBOutlet private weak var sdRentPriceLabel: UILabel!
    @IBOutlet private weak var hdPriceView: UIView!
    @IBOutlet private weak var hdBuyPriceLabel: UILabel!
    @IBOutlet private weak var hdRentPriceLabel: UILabel!
    
    var viewModel = ViewModel() {
        didSet {
            artworkImageView.image = viewModel.artwork
            nameLabel.text = viewModel.name
            genreLabel.text = viewModel.genre
            priceLabel.text = viewModel.price
        }
    }
}

extension SummaryCell: ImagedCell {
    override var imageView: UIImageView {
        return artworkImageView
    }
}

// MARK: - ViewModel
extension SummaryCell {
    struct ViewModel {
        var artwork = UIImage()
        var name = ""
        var genre = ""
        var price = ""
    }
}

 */
