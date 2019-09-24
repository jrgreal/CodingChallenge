//
//  Coordinator.swift
//  CodingChallenge
//
//  Created by Reginald on 22/09/2019.
//  Copyright © 2019 Reginald. All rights reserved.
//

import UIKit


protocol Coordinated: class {
    var coordinator: Coordinator? { get set }
}

protocol Networked: class {
    var networkController: NetworkController? { get set }
}

/// A class for coordinating navigation and applying dependency injection
class Coordinator: NSObject {
    let networkController = AFNetworkController()
    let mainNavigationController: MainNavigationController
    
    init(mainViewController: MainNavigationController) {
        self.mainNavigationController = mainViewController
        super.init()
        configure(viewController: mainViewController)
    }
    
    func forward<T>(value: T, to viewController: UIViewController) {
        switch value {
        case let movie as Movie:
            (viewController as? MovieDetailsViewController)?.movie = movie
        default: break
        }
    }
}

extension Coordinator {
    /// Configure the view controller's dependencies using dependency injection
    func configure(viewController: UIViewController) {
        (viewController as? Coordinated)?.coordinator = self
        (viewController as? Networked)?.networkController = networkController
        if let navigationController = viewController as? UINavigationController {
            navigationController.viewControllers.forEach { configure(viewController: $0) }
        }
    }
}
