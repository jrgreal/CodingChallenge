//
//  MainNavigationController.swift
//  CodingChallenge
//
//  Created by Reginald on 23/09/2019.
//  Copyright © 2019 Reginald. All rights reserved.
//

import UIKit

class MainNavigationController: UINavigationController, Networked, Coordinated, Stateful {
    var networkController: NetworkController?
    var coordinator: Coordinator?
    var stateController: StateController?
}

extension MainNavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchMovies()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        coordinator?.configure(viewController: segue.destination)
    }
}

extension MainNavigationController {
    private func fetchMovies() {
           networkController?.fetchValue(for: APIEndpoint.searchMoviesURL) { [weak self] (result: Result<SearchResult>) in
               guard let movies = try? result.get().results, let destinationController = self?.viewControllers.first else {
                   return
               }
               self?.coordinator?.forward(value: movies, to: destinationController)
           }
       }
}
