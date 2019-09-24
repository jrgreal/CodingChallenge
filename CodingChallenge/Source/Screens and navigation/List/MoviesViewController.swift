//
//  MoviesViewController.swift
//  CodingChallenge
//
//  Created by Reginald on 12/09/2019.
//  Copyright © 2019 Reginald. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController, Networked, Coordinated {
    @IBOutlet private weak var tableView: UITableView!
    var networkController: NetworkController?
    var coordinator: Coordinator?
    private var dataSource: MoviesTableViewDataSource?
    var movies: [Movie] = [] {
        didSet {
            setUpDataSource()
        }
    }
    var lastVisitDate: Date? {
        didSet {
            if let dateText = lastVisitDate?.dateText {
                navigationItem.title = "Your last visit was on " + dateText
            }
        }
    }
}

// MARK: - UIViewController
extension MoviesViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        lastVisitDate = Log.getLastVisitDate()
        fetchMovies()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        coordinator?.configure(viewController: segue.destination)
        if let indexPath = tableView.indexPathForSelectedRow,
            let movie = dataSource?.item(at: indexPath) {
            coordinator?.forward(value: movie, to: segue.destination)
        }
    }
}

// MARK: - UITableViewDelegate
extension MoviesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        fetchImageForRow(at: indexPath)
    }
}

// MARK: - Private
private extension MoviesViewController {
    func fetchMovies() {
        networkController?.fetchValue(for: APIEndpoint.searchMoviesURL) { [weak self] (result: Result<SearchResult>) in
            guard let movies = try? result.get().results else {
                return
            }
            self?.movies = movies
        }
    }
    
    func setUpDataSource() {
        let dataSource = MoviesTableViewDataSource(movies: movies)
        self.dataSource = dataSource
        tableView.dataSource = dataSource
        self.tableView.reloadData()
    }
    
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
