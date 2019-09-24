//
//  NetworkController.swift
//  CodingChallenge
//
//  Created by Reginald on 12/09/2019.
//  Copyright © 2019 Reginald. All rights reserved.
//

import UIKit
import Alamofire

protocol NetworkController {
    func fetchImage(for url: URL, withCompletion completion: @escaping (Result<UIImage>) -> Void)
    func fetchValue<V: Decodable>(for url: URL, withCompletion completion: @escaping (Result<V>) -> Void)
}

class AFNetworkController: NetworkController {
    func fetchImage(for url: URL, withCompletion completion: @escaping (Result<UIImage>) -> Void) {
        AF.request(url).responseData { (response) in
            switch response.result {
            case .success(let data):
                guard let image = UIImage(data: data) else {
                    completion(.failure(DataError.cannotConvertToImage))
                    return
                }
                completion(.success(image))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchValue<V: Decodable>(for url: URL, withCompletion completion: @escaping (Result<V>) -> Void) {
        AF.request(url).responseDecodable { (response: DataResponse<V, AFError>) in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

enum DataError: Error {
    case cannotConvertToImage
}
