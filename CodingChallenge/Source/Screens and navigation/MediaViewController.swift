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
            self?.tableView.reloadData()
        }
    }
}

//extension MediaViewController: RowImageFetching {
//    func fetchableImage(at indexPath: IndexPath) -> FetchableValue<UIImage>? {
//        return dataSource?.item(at: indexPath).image
//    }
//
//    func update(_ image: UIImage, at indexPath: IndexPath) {
//        guard var item = dataSource?.item(at: indexPath) else {
//            return
//        }
//        item.update(image: image)
//        dataSource?.update(item, at: indexPath)
//        if tableView.indexPathsForVisibleRows?.contains(indexPath) ?? false {
//            (tableView.cellForRow(at: indexPath) as? ImagedCell)?.update(image)
//        }
//    }
//}
//
//extension MediaViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        fetchImageForRow(at: indexPath)
//    }
//}

protocol RowImageFetching: Networked {
    func fetchableImage(at indexPath: IndexPath) -> FetchableValue<UIImage>?
    func update(_ image: UIImage, at indexPath: IndexPath)
}

extension RowImageFetching {
    func fetchImageForRow(at indexPath: IndexPath) {
        guard let rowImage = fetchableImage(at: indexPath) else {
            return
        }
        if rowImage.fetchedValue != nil {
            return
        }
        networkController?.fetchImage(for: rowImage.url, withCompletion: { [weak self] result in
            if let image = try? result.get() {
                self?.update(image, at: indexPath)
            }
        })
    }
}

// MARK: - ImageFetching
protocol ImageFetching: Networked {
    associatedtype ModelType: ImagedItem
    var item: FetchableValue<ModelType>? { get set }
    func refreshImage()
}


protocol ImagedItem {
    var image: FetchableValue<UIImage> { get }
    mutating func update(image: UIImage)
}

extension ImageFetching {
    func fetchImage() {
        guard let url = item?.fetchedValue?.image.url else {
            return
        }
        networkController?.fetchImage(for: url) { [weak self] result in
            if let image = try? result.get() {
                self?.update(image: image)
            }
        }
    }
    
    func update(image: UIImage) {
        guard var item = self.item?.fetchedValue else {
            return
        }
        item.update(image: image)
        self.item?.update(newValue: item)
        refreshImage()
    }
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

// MARK: - Media
extension Media: ImagedItem {
    var image: FetchableValue<UIImage> {
        return artwork100
    }
    
    mutating func update(image: UIImage) {
        artwork100.update(newValue: image)
    }
}


