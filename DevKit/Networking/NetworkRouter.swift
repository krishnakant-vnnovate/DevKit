//
//  NetworkRouter.swift
//  DevKit
//
//  Created by Vladyslav Gusakov on 5/13/19.
//  Copyright © 2019 Vladyslav Gusakov. All rights reserved.
//

import Foundation

public class NetworkRouter<Endpoint: EndpointType>: NetworkRouting {
    
    private var task: URLSessionTask?
    
    func request(_ endpoint: Endpoint, completion:  @escaping (Result<Data, NetworkError>) -> Void) {
        let jsonParameterEncoder = JSONParameterEncoder()
        let urlParameterEncoder = URLParameterEncoder()
        let request = URLRequestBuilder(endpoint: endpoint, jsonParameterEncoder: jsonParameterEncoder, urlParameterEncoder: urlParameterEncoder).request
        let session = URLSession.shared
        
        task = session.dataTask(with: request) { data, _, error in
            if let error = error {
                completion(.failure(.requestFailed(error)))
                return
            }
            
            if let data = data {
                completion(.success(data))
            } else {
                completion(.failure(.internalError))
            }
        }
        
        task?.resume()
    }
    
    func cancel() {
        task?.cancel()
    }
}
