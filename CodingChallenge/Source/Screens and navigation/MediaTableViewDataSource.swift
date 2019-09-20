//
//  MediaTableViewDataSource.swift
//  CodingChallenge
//
//  Created by Reginald on 12/09/2019.
//  Copyright © 2019 Reginald. All rights reserved.
//

import UIKit

class MediaTableViewDataSource: NSObject {
    var dataOrganizer: DataOrganizer
    
    init(media: [Media]) {
        dataOrganizer = DataOrganizer(items: media)
        super.init()
    }
    
    func item(at indexPath: IndexPath) -> Media {
        return dataOrganizer[indexPath]
    }
    
    func image(at indexPath: IndexPath) -> UIImage? {
        return dataOrganizer[indexPath].artwork100.fetchedValue
    }
    
    func update(_ item: Media, at indexPath: IndexPath) {
        dataOrganizer[indexPath] = item
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
        artwork = media.artwork100.fetchedValue ??  #imageLiteral(resourceName: "placeholder")
        name = media.trackName ?? "No track name"
        genre = media.primaryGenre
        price = "\(media.trackPrice ?? 0) \(media.currency)"
    }
}
