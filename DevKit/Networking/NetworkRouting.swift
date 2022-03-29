//
//  NetworkRouting.swift
//  DevKit
//
//  Created by Vladyslav Gusakov on 5/13/19.
//  Copyright © 2019 Vladyslav Gusakov. All rights reserved.
//

import Foundation

public typealias NetworkRouterCompletion = (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void

protocol NetworkRouting: class {
    associatedtype Endpoint: EndpointType
    
    func request(_ endpoint: Endpoint, completion: @escaping (Result<Data, NetworkError>) -> Void)
    func cancel()
}
