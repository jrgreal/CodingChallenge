//
//  MediaViewController.swift
//  CodingChallenge
//
//  Created by Reginald on 12/09/2019.
//  Copyright © 2019 Reginald. All rights reserved.
//

import UIKit

class MediaViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    var networkController: NetworkController? = NetworkController(cachingController: CachingController())
    private var dataSource: MediaTableViewDataSource?
}

extension MediaViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        networkController?.fetchValue(for: APIEndpoint.searchTrackURL) { [weak self] (result: Result<SearchResult>) in
            print(result)
            guard let media = try? result.get().media else {
                return
            }
            let dataSource = MediaTableViewDataSource(media: media)
            self?.dataSource = dataSource
            self?.tableView.dataSource = dataSource
            self?.tableView.delegate = self
            self?.tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? MediumViewController {
            if let indexPath = tableView.indexPathForSelectedRow,
                let item = dataSource?.item(at: indexPath) {
                destination.medium = item
            }
        }
    }
}

extension MediaViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        fetchImageForRow(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension MediaViewController {
    func fetchImageForRow(at indexPath: IndexPath) {
        guard let fetchableImage = dataSource?.fetchableImage(at: indexPath) else {
            return
        }
        if fetchableImage.fetchedValue != nil {
            return
        }
        networkController?.fetchImage(for: fetchableImage.url, withCompletion: { [weak self] result in
            print("fetching...")
            if let image = try? result.get() {
                self?.update(image, at: indexPath)
            }
        })
    }
    
    func update(_ image: UIImage, at indexPath: IndexPath) {
        dataSource?.update(image, at: indexPath)
        if tableView.indexPathsForVisibleRows?.contains(indexPath) ?? false {
            (tableView.cellForRow(at: indexPath) as? MediumCell)?.update(image)
        }
    }
}

