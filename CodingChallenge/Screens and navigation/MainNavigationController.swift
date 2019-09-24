//
//  MainNavigationController.swift
//  CodingChallenge
//
//  Created by Reginald on 23/09/2019.
//  Copyright © 2019 Reginald. All rights reserved.
//

import UIKit

class MainNavigationController: UINavigationController, Networked, Coordinated {
    var networkController: NetworkController?
    var coordinator: Coordinator?
}

extension MainNavigationController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        coordinator?.configure(viewController: segue.destination)
    }
}
