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
    
    init(media: [Movie]) {
        dataOrganizer = DataOrganizer(items: media)
        super.init()
    }
    
    func item(at indexPath: IndexPath) -> Movie {
        return dataOrganizer[indexPath]
    }
    
    func fetchableImage(at indexPath: IndexPath) -> FetchableValue<UIImage> {
        return dataOrganizer[indexPath].artwork100
    }
    
    func update(_ item: Movie, at indexPath: IndexPath) {
        dataOrganizer[indexPath] = item
    }
    
    func update(_ image: UIImage, at indexPath: IndexPath) {
        dataOrganizer[indexPath].artwork100.update(newValue: image)
    }
}

// MARK: - UITableViewDataSource
extension MediaTableViewDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataOrganizer.rowsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MediumCell = tableView.dequeueReusableCell(for: indexPath)
        cell.viewModel = MediumCell.ViewModel(media: dataOrganizer[indexPath])
        print(cell.viewModel.artwork.size)
        return cell
    }
}

// MARK: - DataOrganizer
extension MediaTableViewDataSource {
    struct DataOrganizer {
        var items: [Movie]
        
        var rowsCount: Int {
            return items.count
        }
        
        subscript(indexPath: IndexPath) -> Movie {
            get { return items[indexPath.row] }
            set { items[indexPath.row] = newValue }
        }
    }
}

// MARK: - MediumCell.ViewModel
extension MediumCell.ViewModel {
    init(media: Movie) {
        artwork = media.artwork100.fetchedValue ??  #imageLiteral(resourceName: "placeholder")
        name = media.trackName ?? "No track name"
        genre = media.primaryGenre
        price = "\(media.trackPrice ?? 0) \(media.currency)"
    }
}
