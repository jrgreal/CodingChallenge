//
//  MoviesTableViewDataSource.swift
//  CodingChallenge
//
//  Created by Reginald on 12/09/2019.
//  Copyright © 2019 Reginald. All rights reserved.
//

import UIKit

/// Data source for displaying a list of movies
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
        return dataOrganizer[indexPath].artwork
    }
    
    func update(_ image: UIImage, at indexPath: IndexPath) {
        dataOrganizer[indexPath].artwork.update(newValue: image)
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
        artwork = movie.artwork.fetchedValue ??  #imageLiteral(resourceName: "placeholder")
        name = movie.trackName
        genre = movie.primaryGenre        
        sdBuyPrice =  movie.trackPrice.map({"BUY \($0) \(movie.currency)"}) ?? ""
        sdRentPrice = movie.trackRentalPrice.map({"RENT \($0) \(movie.currency)"}) ?? ""
        hdBuyPrice = movie.trackHDPrice.map({"BUY \($0) \(movie.currency)"}) ?? ""
        hdRentPrice = movie.trackHDRentalPrice.map({"RENT \($0) \(movie.currency)"}) ?? ""
    }
}
