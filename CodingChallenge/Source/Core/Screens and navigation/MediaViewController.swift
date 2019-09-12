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
    let networkController = NetworkController(cachingController: CachingController())
    private var dataSource: MediaTableViewDataSource?
}

extension MediaViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        networkController.fetchValue(for: APIEndpoint.searchTrackURL) { [weak self] (result: Result<SearchResult>) in
            print(result)
            guard let media = try? result.get().media else {
                return
            }
            let dataSource = MediaTableViewDataSource(media: media)
            self?.dataSource = dataSource
            self?.tableView.dataSource = dataSource
            self?.tableView.reloadData()
        }
    }
}

