//
//  MainCoordinator.swift
//  CodingChallenge
//
//  Created by Reginald on 20/09/2019.
//  Copyright © 2019 Reginald. All rights reserved.
//

import UIKit

class MainCoordinator: NSObject {
    func mediaViewController(_ viewController: MediaViewController, didSelectMedium medium: Medium) {
//        view
        viewController.performSegue(withIdentifier: Segues.showMedium, sender: nil)
    }
}
extension MainCoordinator {
    struct Segues {
        static let showMedium = "ShowMedium"
    }
}
