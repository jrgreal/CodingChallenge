//
//  MediaTableViewDataSource.swift
//  CodingChallenge
//
//  Created by Reginald on 12/09/2019.
//  Copyright © 2019 Reginald. All rights reserved.
//

import UIKit

class MediaTableViewDataSource: NSObject {
    let dataOrganizer: DataOrganizer
    
    init(media: [Media]) {
        dataOrganizer = DataOrganizer(items: media)
        super.init()
    }
}

// MARK: - UITableViewDataSource
extension MediaTableViewDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataOrganizer.rowsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MediaCell = tableView.dequeueReusableCell(for: indexPath)
        cell.viewModel = MediaCell.ViewModel(media: dataOrganizer[indexPath])
        return cell
    }
}

// MARK: - DataOrganizer
extension MediaTableViewDataSource {
    struct DataOrganizer {
        var items: [Media]
        
        var rowsCount: Int {
            return items.count
        }
        
        subscript(indexPath: IndexPath) -> Media {
            get { return items[indexPath.row] }
            set { items[indexPath.row] = newValue }
        }
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
