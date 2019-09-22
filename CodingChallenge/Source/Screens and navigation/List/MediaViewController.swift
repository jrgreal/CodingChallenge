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
    var networkController: NetworkController? = NetworkController()
    private var dataSource: MediaTableViewDataSource?
    var media: [Medium] = []
    var lastVisitDate: Date? {
        didSet {
            if let dateText = lastVisitDate?.dateText {
                navigationItem.title = "Your last visit was on " + dateText
            }
        }
    }
}

extension MediaViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        networkController?.fetchValue(for: APIEndpoint.searchTrackURL) { [weak self] (result: Result<SearchResult>) in
            guard let media = try? result.get().media else {
                return
            }
            self?.setUpDataSource(with: media)
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
    
    override func encodeRestorableState(with coder: NSCoder) {
        super.encodeRestorableState(with: coder)
        coder.encode(Date(), forKey: CodingKey.lastVisitDate)
        guard let data = try? JSONEncoder().encode(media) else {
            return
        }
        coder.encode(data, forKey: CodingKey.media)
    }
    
    override func decodeRestorableState(with coder: NSCoder) {
        super.decodeRestorableState(with: coder)
        let lastVisitDate = coder.decodeObject(forKey: CodingKey.lastVisitDate) as? Date
        self.lastVisitDate = lastVisitDate
        
        guard let data = coder.decodeObject(forKey: CodingKey.media) as? Data,
            let media = try? JSONDecoder().decode([Medium].self, from: data) else {
            return
        }
        self.media = media
    }
    
    override func applicationFinishedRestoringState() {
        let media = self.media
        guard !media.isEmpty else {
            return
        }
        setUpDataSource(with: media)
    }
    
    func setUpDataSource(with media: [Medium]) {
        self.media = media
        let dataSource = MediaTableViewDataSource(media: media)
        self.dataSource = dataSource
        tableView.dataSource = dataSource
        self.tableView.reloadData()
    }
}

extension MediaViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        fetchImageForRow(at: indexPath)
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

extension MediaViewController {
    struct CodingKey {
        static let media = "media"
        static let lastVisitDate = "lastVisitDate"
    }
}
