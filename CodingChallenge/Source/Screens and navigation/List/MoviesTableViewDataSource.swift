//
//  MoviesTableViewDataSource.swift
//  CodingChallenge
//
//  Created by Reginald on 12/09/2019.
//  Copyright © 2019 Reginald. All rights reserved.
//

import UIKit

class MoviesTableViewDataSource: NSObject {
    var dataOrganizer: DataOrganizer
    
    init(movies: [Movie]) {
        dataOrganizer = DataOrganizer(items: movies)
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
extension MoviesTableViewDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataOrganizer.rowsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MovieCell = tableView.dequeueReusableCell(for: indexPath)
        cell.viewModel = MovieCell.ViewModel(movie: dataOrganizer[indexPath])
        print(cell.viewModel.artwork.size)
        return cell
    }
}

// MARK: - DataOrganizer
extension MoviesTableViewDataSource {
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

// MARK: - MovieCell.ViewModel
extension MovieCell.ViewModel {
    init(movie: Movie) {
        artwork = movie.artwork100.fetchedValue ??  #imageLiteral(resourceName: "placeholder")
        name = movie.trackName
        genre = movie.primaryGenre
        price = "\(movie.trackPrice ?? 0) \(movie.currency)"
    }
}
