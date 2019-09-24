//
//  MovieDetailsTableViewDataSource.swift
//  CodingChallenge
//
//  Created by Reginald on 20/09/2019.
//  Copyright © 2019 Reginald. All rights reserved.
//

import UIKit

/// Data source for displaying movie details
class MovieDetailsTableViewDataSource: NSObject {
    private let organizer: DataOrganizer
    private var movie: Movie
    
    init(movie: Movie) {
        self.movie = movie
        organizer = DataOrganizer()
        super.init()
    }
    
    func fetchableImage() -> FetchableValue<UIImage> {
        return movie.artwork
    }
    
    func update(_ image: UIImage) {
        movie.artwork.update(newValue: image)
    }
}

// MARK: - UITableViewDataSource
extension MovieDetailsTableViewDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return organizer.rowsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = organizer.row(at: indexPath.row)
        let cell = tableView.dequeueReusableCell(with: row.cellType, for: indexPath)
        if let configurableCell = cell as? MovieConfigurable {
            configurableCell.configure(with: movie)
        }
        return cell
    }
}


// MARK: - DataOrganizer
extension MovieDetailsTableViewDataSource {
    /// An organizer which defines how rows are arranged
    struct DataOrganizer {
        private let rows: [MovieDetailsViewController.Row]
        
        var rowsCount: Int {
            return rows.count
        }
        
        init() {
            var rows: [MovieDetailsViewController.Row] = []
            rows.append(.summary)
            rows.append(.description)
            self.rows = rows
        }

        func row(at index: Int) -> MovieDetailsViewController.Row {
            return rows[index]
        }
    }
}

//MARK: - MovieConfigurable
protocol MovieConfigurable {
    func configure(with movie: Movie)
}


extension SummaryCell: MovieConfigurable {
    func configure(with movie: Movie) {
        viewModel = ViewModel(movie: movie)
    }
}

extension DescriptionCell: MovieConfigurable {
    func configure(with movie: Movie) {
        longDescription = movie.longDescription
    }
}
