//
//  ImageRequest.swift
//  CodingChallenge
//
//  Created by Reginald on 12/09/2019.
//  Copyright © 2019 Reginald. All rights reserved.
//

import UIKit

class ImageRequest {
    let url: URL
    let session: URLSession
    var task: URLSessionDataTask?
    
    init(url: URL, session: URLSession) {
        self.url = url
        self.session = session
    }
}

extension ImageRequest: NetworkRequest {
    var urlRequest: URLRequest {
        return URLRequest(url: url)
    }
    
    func deserialize(_ data: Data?, response: HTTPURLResponse) throws -> UIImage {
        guard let data = data, let image = UIImage(data: data) else {
            throw NetworkError.unrecoverable
        }
        return image
    }
}

