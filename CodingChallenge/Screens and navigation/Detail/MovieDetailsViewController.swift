//
//  MovieDetailsViewController.swift
//  CodingChallenge
//
//  Created by Reginald on 20/09/2019.
//  Copyright © 2019 Reginald. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController, Networked {
    @IBOutlet private weak var tableView: UITableView!
    private var dataSource: MovieDetailsTableViewDataSource?
    var networkController: NetworkController?
     
    var movie: Movie?
}

// MARK: - UIViewController
extension MovieDetailsViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let movie = movie else {
            return
        }
        setUpDataSource(with: movie)
        fetchImage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchImage()
    }
    
    override func encodeRestorableState(with coder: NSCoder) {
        super.encodeRestorableState(with: coder)
        if let movie = movie {
            coder.encode(movie)
        }
    }
    
    override func decodeRestorableState(with coder: NSCoder) {
        super.decodeRestorableState(with: coder)
        movie = coder.decode()
        
    }
    
    override func applicationFinishedRestoringState() {
        guard let movie = movie else {
            return
        }
        setUpDataSource(with: movie)
    }
}

// MARK: - Private
private extension MovieDetailsViewController {
    func setUpDataSource(with movie: Movie) {
        self.movie = movie
        dataSource = MovieDetailsTableViewDataSource(movie: movie)
        tableView.dataSource = dataSource
        tableView.reloadData()
    }
    
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

// MARK: - Row
extension MovieDetailsViewController {
    /// An enum for all the possible types of UITableViewCell used by MovieDetailsViewController
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
