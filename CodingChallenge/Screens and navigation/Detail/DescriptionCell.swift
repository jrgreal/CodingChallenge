//
//  DescriptionCell.swift
//  CodingChallenge
//
//  Created by Reginald on 20/09/2019.
//  Copyright © 2019 Reginald. All rights reserved.
//

import UIKit

class DescriptionCell: UITableViewCell {
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    var longDescription: String = "" {
        didSet {
            descriptionLabel.text = longDescription
        }
    }
}
