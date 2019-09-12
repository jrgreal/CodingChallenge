//
//  NetworkController.swift
//  CodingChallenge
//
//  Created by Reginald on 12/09/2019.
//  Copyright © 2019 Reginald. All rights reserved.
//

import Foundation
import UIKit

class NetworkController {
    private let cachingController: CachingController
    private var session = URLSession(configuration: .default, delegate: nil, delegateQueue: .main)
    private var requests: [URL: AnyObject] = [:]
    
    init(cachingController: CachingController) {
        self.cachingController = cachingController
    }
    
    func fetchValue<V: Decodable>(for url: URL) -> V? {
        let cachedValue: CachedValue<V>? = cachingController.fetchValue(for: url)
        return cachedValue?.value
    }
    
    func fetchImage(for url: URL, withCompletion completion: @escaping (Result<UIImage>) -> Void) {
        let imageRequest = ImageRequest(url: url, session: session)
        requests[url] = imageRequest
        imageRequest.execute { [weak self] (result) in
            self?.requests[url] = nil
            completion(result)
        }
    }
    
    func fetchValue<V: Decodable>(for url: URL, withCompletion completion: @escaping (Result<V>) -> Void) {
        let apiRequest = FetchRequest<V>(url: url, session: session)
        requests[url] = apiRequest
        apiRequest.execute { [weak self] (result) in
            completion(result)
            self?.requests[url] = nil
        }
    }
}
