//
//  MediaTableViewDataSource.swift
//  CodingChallenge
//
//  Created by Reginald on 12/09/2019.
//  Copyright © 2019 Reginald. All rights reserved.
//

import UIKit

class MediaTableViewDataSource: NSObject {
    let dataOrganizer: ArrayDataSourceOrganizer<Media>
    var viewModelCache: [IndexPath: MediaCell.ViewModel] = [:]
    
    init(media: [Media]) {
        dataOrganizer = ArrayDataSourceOrganizer(items: media)
        super.init()
    }
}

// MARK: ArrayTableViewDataSource
extension MediaTableViewDataSource: ArrayTableViewDataSource {
    func viewModel(for value: Media) -> MediaCell.ViewModel {
        return MediaCell.ViewModel(media: value)
    }
    
    func configure(cell: MediaCell, with viewModel: MediaCell.ViewModel) {
        cell.viewModel = viewModel
    }
}

// MARK: UITableViewDataSource
extension MediaTableViewDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return cell(from: tableView, for: indexPath)
    }
}


// MARK: - MediaCell.ViewModel
extension MediaCell.ViewModel {
    init(media: Media) {
        artwork = #imageLiteral(resourceName: "placeholder")
        name = media.trackName ?? "No track name"
        genre = media.primaryGenre
        price = "\(media.trackPrice ?? 0) \(media.currency)"
    }
}
