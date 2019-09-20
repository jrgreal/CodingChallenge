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
}

extension MediaViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        fetchImageForRow(at: indexPath)
    }
    
    func fetchImageForRow(at indexPath: IndexPath) {
        guard let fetchableImage = dataSource?.item(at: indexPath).artwork100 else {
            return
        }
        
        if fetchableImage.fetchedValue != nil {
            return
        }
        
        print(fetchableImage)
        networkController?.fetchImage(for: fetchableImage.url, withCompletion: { [weak self] result in
            if let image = try? result.get() {
                self?.update(image, at: indexPath)
            }
        })
    }
    
    func update(_ image: UIImage, at indexPath: IndexPath) {
        guard var item = dataSource?.item(at: indexPath) else {
            return
        }
        item.update(image: image)
        dataSource?.update(item, at: indexPath)
        
//        tableView.dataSource = dataSource
//        tableView.reloadRows(at: [indexPath], with: .fade)
        
        if tableView.indexPathsForVisibleRows?.contains(indexPath) ?? false {
            (tableView.cellForRow(at: indexPath) as? MediumCell)?.update(image)
        }
    }
//
//    func refreshImage() {
////        setUpDataSource()
//        tableView.dataSource = dataSource
//        tableView.reloadRows(at: <#T##[IndexPath]#>, with: <#T##UITableView.RowAnimation#>)
//        if let avatarIndexPath = dataSource?.indexPath(for: Section.SummaryRow.avatar) {
//            tableView.reloadRows(at: [avatarIndexPath], with: .fade)
//        }
//    }
}

// MARK: - ImagedCell
protocol ImagedCell {
    var imageView: UIImageView { get }
}

extension ImagedCell {
    func update(_ image: UIImage) {
        UIView.transition(with: imageView, duration: 0.2, options: .transitionCrossDissolve, animations: {
            self.imageView.image = image
        }, completion: nil)
    }
}

// MARK: - Medium
extension Medium {
    var image: FetchableValue<UIImage> {
        return artwork100
    }

    mutating func update(image: UIImage) {
        artwork100.update(newValue: image)
    }
}


