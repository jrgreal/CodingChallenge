//
//  MediumTableViewDataSource.swift
//  CodingChallenge
//
//  Created by Reginald on 20/09/2019.
//  Copyright © 2019 Reginald. All rights reserved.
//

import UIKit

class MediumTableViewDataSource: NSObject {
    private let organizer: DataOrganizer
    private var medium: Movie
    
    init(medium: Movie) {
        self.medium = medium
        organizer = DataOrganizer(medium: medium)
        super.init()
    }
    
    func fetchableImage() -> FetchableValue<UIImage> {
        return medium.artwork100
    }
    
    func update(_ image: UIImage) {
        medium.artwork100.update(newValue: image)
    }
}

extension MediumTableViewDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return organizer.rowsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = organizer.row(at: indexPath.row)
        let cell = tableView.dequeueReusableCell(with: row.cellType, for: indexPath)
        if let configurableCell = cell as? MediumConfigurable {
            configurableCell.configure(with: medium)
        }
        return cell
    }
}


// MARK: - DataOrganizer
extension MediumTableViewDataSource {
    struct DataOrganizer {
        private let rows: [MediumViewController.Row]
        
        var rowsCount: Int {
            return rows.count
        }
        
        init(medium: Movie) {
            var rows: [MediumViewController.Row] = []
            rows.append(.summary)
            rows.append(.description)
            self.rows = rows
        }

        func row(at index: Int) -> MediumViewController.Row {
            return rows[index]
        }
    }
}

// MARK: - MediumCell.ViewModel
extension SummaryCell.ViewModel {
    init(media: Movie) {
        artwork = media.artwork100.fetchedValue ??  #imageLiteral(resourceName: "placeholder")
        name = media.trackName ?? "No track name"
        genre = media.primaryGenre
        price = "\(media.trackPrice ?? 0) \(media.currency)"
    }
}

//MARK: - MediumConfigurable
protocol MediumConfigurable {
    func configure(with medium: Movie)
}


extension SummaryCell: MediumConfigurable {
    func configure(with medium: Movie) {
        viewModel = ViewModel(media: medium)
    }
}

extension DescriptionCell: MediumConfigurable {
    func configure(with medium: Movie) {
        longDescription = medium.longDescription ?? "No information available."
    }
}
