//
//  MediumViewController.swift
//  CodingChallenge
//
//  Created by Reginald on 20/09/2019.
//  Copyright © 2019 Reginald. All rights reserved.
//

import UIKit

class MediumViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    private var dataSource: MediumTableViewDataSource?
    var networkController: NetworkController? = NetworkController()
    
    var medium: Medium?
}

extension MediumViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        guard let medium = medium else {
            return
        }
        setUpDataSource(with: medium)
    }
    
    override func encodeRestorableState(with coder: NSCoder) {
        super.encodeRestorableState(with: coder)
        guard let medium = medium else {
            return
        }
        if let data = try? JSONEncoder().encode(medium) {
            coder.encode(data, forKey: CodingKey.medium)
            return
        }
    }
    
    override func decodeRestorableState(with coder: NSCoder) {
        super.decodeRestorableState(with: coder)
        if let data = coder.decodeObject(forKey: CodingKey.medium) as? Data, let medium = try? JSONDecoder().decode(Medium.self, from: data) {
            self.medium = medium
            return
        }
    }
    
    override func applicationFinishedRestoringState() {
        guard let medium = medium else {
            return
        }
        setUpDataSource(with: medium)
    }
    
    func setUpDataSource(with medium: Medium) {
        self.medium = medium
        dataSource = MediumTableViewDataSource(medium: medium)
        tableView.dataSource = dataSource
        tableView.reloadData()
    }
}

extension MediumViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        fetchImageForRow(at: indexPath)
    }
}

extension MediumViewController {
    func fetchImageForRow(at indexPath: IndexPath) {
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

extension MediumViewController {
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

extension MediumViewController {
    struct CodingKey {
        static let medium = "medium"
    }
}
