//
//  MovieDetailsViewController.swift
//  CodingChallenge
//
//  Created by Reginald on 20/09/2019.
//  Copyright © 2019 Reginald. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    private var dataSource: MovieDetailsTableViewDataSource?
    var networkController: NetworkController? = AFNetworkController()
    
    var movie: Movie?
}

extension MovieDetailsViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let movie = movie else {
            return
        }
        setUpDataSource(with: movie)
    }
    
    override func encodeRestorableState(with coder: NSCoder) {
        super.encodeRestorableState(with: coder)
        guard let movie = movie else {
            return
        }
        if let data = try? JSONEncoder().encode(movie) {
            coder.encode(data, forKey: CodingKey.movie)
            return
        }
    }
    
    override func decodeRestorableState(with coder: NSCoder) {
        super.decodeRestorableState(with: coder)
        if let data = coder.decodeObject(forKey: CodingKey.movie) as? Data, let movie = try? JSONDecoder().decode(Movie.self, from: data) {
            self.movie = movie
            return
        }
    }
    
    override func applicationFinishedRestoringState() {
        guard let movie = movie else {
            return
        }
        setUpDataSource(with: movie)
    }
    
    func setUpDataSource(with movie: Movie) {
        self.movie = movie
        dataSource = MovieDetailsTableViewDataSource(movie: movie)
        tableView.dataSource = dataSource
        tableView.reloadData()
        fetchImage()
    }
}

extension MovieDetailsViewController {
    func fetchImage() {
        guard let fetchableImage = dataSource?.fetchableImage() else {
            return
        }
        if fetchableImage.fetchedValue != nil {
            return
        }
        networkController?.fetchImage(for: fetchableImage.url, withCompletion: { [weak self] result in
            if let image = try? result.get() {
                self?.dataSource?.update(image)
                self?.tableView.reloadData()
            }
        })
    }
}

extension MovieDetailsViewController {
    enum Row {
        case summary
        case description
        
        var cellType: UITableViewCell.Type {
            switch self {
            case .summary: return SummaryCell.self
            case .description: return DescriptionCell.self
            }
        }
    }
}

extension MovieDetailsViewController {
    struct CodingKey {
        static let movie = "movie"
    }
}
