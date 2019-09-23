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

class Coordinator: NSObject {
    let networkController = AFNetworkController()
    var mainNavigationController: MainNavigationController
    
    init(mainViewController: MainNavigationController) {
        self.mainNavigationController = mainViewController
        super.init()
        configure(viewController: mainViewController)
    }
    
    func forward<T>(value: T, to viewController: UIViewController) {
        switch value {
        case let movies as [Movie]:
            (viewController as? MoviesViewController)?.movies = movies
        case let movie as Movie:
            (viewController as? MovieDetailsViewController)?.movie = movie
        default: break
        }
    }
}

extension Coordinator {
    func configure(viewController: UIViewController) {
        (viewController as? Coordinated)?.coordinator = self
        (viewController as? Networked)?.networkController = networkController
        if let navigationController = viewController as? UINavigationController,
            let rootViewController = navigationController.viewControllers.first {
            configure(viewController: rootViewController)
        }
    }
}
