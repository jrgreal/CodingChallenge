//
//  ImagedCell.swift
//  CodingChallenge
//
//  Created by Reginald on 20/09/2019.
//  Copyright © 2019 Reginald. All rights reserved.
//

import UIKit

// MARK: - ImagedCell
protocol ImagedCell {
    var imageView: UIImageView { get }
}

extension ImagedCell {
    func update(_ image: UIImage) {
        UIView.transition(with: imageView, duration: 0.2, options: .transitionCrossDissolve, animations: {
            self.imageView.image = image
        }, completion: nil)
    }
}

