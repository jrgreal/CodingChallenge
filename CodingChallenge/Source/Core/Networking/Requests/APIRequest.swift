//
//  APIRequest.swift
//  CodingChallenge
//
//  Created by Reginald on 12/09/2019.
//  Copyright © 2019 Reginald. All rights reserved.
//

import Foundation

// MARK: - APIRequest
protocol APIRequest: NetworkRequest, Validable {
    var url: URL { get }
}

extension APIRequest {
    var defaultURLRequest: URLRequest {
        return URLRequest(url: url)
    }
    
    func validate(_ response: HTTPURLResponse) throws {
        if response.statusCode == 401 {
            throw NetworkError.unauthorized
        }
    }
}

// MARK: - FetchRequest
class FetchRequest<ModelType: Decodable>: APIRequest, JSONDataRequest {
    let url: URL
    var task: URLSessionDataTask?
    let session: URLSession
    
    init(url: URL, session: URLSession) {
        self.url = url
        self.session = session
    }
}

extension FetchRequest: NetworkRequest {
    var urlRequest: URLRequest {
        return defaultURLRequest
    }
}

// MARK: - ListRequest
protocol ArrayType {}
extension Array: ArrayType {}

class ListRequest<ModelType: Decodable & ArrayType>: APIRequest, JSONDataRequest {
    let url: URL
    var task: URLSessionDataTask?
    let session: URLSession
    
    init(url: URL, session: URLSession) {
        self.url = url
        self.session = session
    }
}

// MARK: NetworkRequest
extension ListRequest: NetworkRequest {
    var urlRequest: URLRequest {
        return defaultURLRequest
    }
}

struct APIEndpoint {
    static let searchTrackURL = "https://itunes.apple.com/search?term=star&amp;country=au&amp;media=movie&amp;all"
}
