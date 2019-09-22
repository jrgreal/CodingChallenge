//
//  MoviesViewController.swift
//  CodingChallenge
//
//  Created by Reginald on 12/09/2019.
//  Copyright © 2019 Reginald. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    var networkController: NetworkController? = NetworkController()
    private var dataSource: MoviesTableViewDataSource?
    var movies: [Movie] = []
    var lastVisitDate: Date? {
        didSet {
            if let dateText = lastVisitDate?.dateText {
                navigationItem.title = "Your last visit was on " + dateText
            }
        }
    }
}

extension MoviesViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        networkController?.fetchValue(for: APIEndpoint.searchTrackURL) { [weak self] (result: Result<SearchResult>) in
            guard let movies = try? result.get().results else {
                return
            }
            self?.setUpDataSource(with: movies)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? MovieDetailsViewController {
            if let indexPath = tableView.indexPathForSelectedRow,
                let item = dataSource?.item(at: indexPath) {
                destination.movie = item
            }
        }
    }
    
    override func encodeRestorableState(with coder: NSCoder) {
        super.encodeRestorableState(with: coder)
        coder.encode(Date(), forKey: CodingKey.lastVisitDate)
        guard let data = try? JSONEncoder().encode(movies) else {
            return
        }
        coder.encode(data, forKey: CodingKey.movies)
    }
    
    override func decodeRestorableState(with coder: NSCoder) {
        super.decodeRestorableState(with: coder)
        let lastVisitDate = coder.decodeObject(forKey: CodingKey.lastVisitDate) as? Date
        self.lastVisitDate = lastVisitDate
        
        guard let data = coder.decodeObject(forKey: CodingKey.movies) as? Data,
            let movies = try? JSONDecoder().decode([Movie].self, from: data) else {
            return
        }
        self.movies = movies
    }
    
    override func applicationFinishedRestoringState() {
       if !movies.isEmpty {
             setUpDataSource(with: movies)
        }
    }
    
    func setUpDataSource(with movies: [Movie]) {
        self.movies = movies
        let dataSource = MoviesTableViewDataSource(movies: movies)
        self.dataSource = dataSource
        tableView.dataSource = dataSource
        self.tableView.reloadData()
    }
}

extension MoviesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        fetchImageForRow(at: indexPath)
    }
}

extension MoviesViewController {
    func fetchImageForRow(at indexPath: IndexPath) {
        guard let fetchableImage = dataSource?.fetchableImage(at: indexPath) else {
            return
        }
        if fetchableImage.fetchedValue != nil {
            return
        }
        networkController?.fetchImage(for: fetchableImage.url, withCompletion: { [weak self] result in
            if let image = try? result.get() {
                self?.update(image, at: indexPath)
            }
        })
    }
    
    func update(_ image: UIImage, at indexPath: IndexPath) {
        dataSource?.update(image, at: indexPath)
        if tableView.indexPathsForVisibleRows?.contains(indexPath) ?? false {
            (tableView.cellForRow(at: indexPath) as? MovieCell)?.update(image)
        }
    }
}

extension MoviesViewController {
    struct CodingKey {
        static let movies = "movies"
        static let lastVisitDate = "lastVisitDate"
    }
}
