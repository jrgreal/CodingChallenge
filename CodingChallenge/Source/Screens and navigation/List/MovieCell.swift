//
//  MovieCell.swift
//  CodingChallenge
//
//  Created by Reginald on 12/09/2019.
//  Copyright © 2019 Reginald. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {
    @IBOutlet private weak var artworkImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var genreLabel: UILabel!
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
            
            let sdBuyPrice = viewModel.sdBuyPrice
            let sdRentPrice = viewModel.sdRentPrice
            sdBuyPriceLabel.text = sdBuyPrice
            sdRentPriceLabel.text = sdRentPrice
            sdPriceView.isHidden = sdBuyPrice.isEmpty && sdRentPrice.isEmpty
            
            let hdBuyPrice = viewModel.hdBuyPrice
            let hdRentPrice = viewModel.hdRentPrice
            hdBuyPriceLabel.text = hdBuyPrice
            hdRentPriceLabel.text = hdRentPrice
            hdPriceView.isHidden = hdBuyPrice.isEmpty && hdRentPrice.isEmpty
        }
    }
}

extension MovieCell: ImagedCell {
    override var imageView: UIImageView {
        return artworkImageView
    }
}

// MARK: - ViewModel
extension MovieCell {
    struct ViewModel {
        var artwork = UIImage()
        var name = ""
        var genre = ""
        var sdBuyPrice = ""
        var sdRentPrice = ""
        var hdBuyPrice = ""
        var hdRentPrice = ""
    }
}
