//
//  UITableView.swift
//  CodingChallenge
//
//  Created by Reginald on 13/09/2019.
//  Copyright © 2019 Reginald. All rights reserved.
//

import UIKit

extension UITableView {
    
    /// Returns a reusable table view cell of inferred type where the identifier has the same name as that cell type
    func dequeueReusableCell<Cell: UITableViewCell>(for indexPath: IndexPath) -> Cell {
        return dequeueReusableCell(withIdentifier: String(describing: Cell.self), for: indexPath) as! Cell
    }
    
    /// Returns a reusable table view cell where the identifier has the same name as the cell type
    func dequeueReusableCell<Cell: UITableViewCell>(with type: Cell.Type, for indexPath: IndexPath) -> UITableViewCell {
        return dequeueReusableCell(withIdentifier: String(describing: type), for: indexPath) as! Cell
    }
}
