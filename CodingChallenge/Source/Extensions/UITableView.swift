//
//  UITableView.swift
//  CodingChallenge
//
//  Created by Reginald on 13/09/2019.
//  Copyright © 2019 Reginald. All rights reserved.
//

import UIKit

extension UITableView {
    //cell identifier should be the same as the cell type name
    func dequeueReusableCell<Cell: UITableViewCell>(for indexPath: IndexPath) -> Cell {
        return dequeueReusableCell(withIdentifier: String(describing: Cell.self), for: indexPath) as! Cell
    }
    
    func dequeueReusableCell<Cell: UITableViewCell>(with type: Cell.Type, for indexPath: IndexPath) -> UITableViewCell {
        return dequeueReusableCell(withIdentifier: String(describing: type), for: indexPath) as! Cell
    }
}
