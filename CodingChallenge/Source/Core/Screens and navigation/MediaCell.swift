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
    
//    private func fetchProductImage(from url: URL) {
//        productImageView.image = nil
//        let productImageRequest = ImageRequest(url: url)
//        productImageRequest.fetch { [weak self] (result) in
//            switch result {
//            case .success(let image): self?.productImageView.image = image
//            case .failure: self?.productImageView.image = nil
//            }
//        }
//    }
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
