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
    
    var medium: Medium?
}

extension MediumViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let medium = medium else {
            return
        }
        dataSource = MediumTableViewDataSource(medium: medium)
        tableView.dataSource = dataSource
        tableView.reloadData()
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
