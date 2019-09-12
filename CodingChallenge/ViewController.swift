//
//  ViewController.swift
//  CodingChallenge
//
//  Created by Reginald on 12/09/2019.
//  Copyright © 2019 Reginald. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let networkController = NetworkController(cachingController: CachingController())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    
        networkController.fetchValue(for: APIEndpoint.searchTrackURL) { (result: Result<SearchResult>) in
            print(result)
        }
        
        
    }


}

