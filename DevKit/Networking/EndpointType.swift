//
//  EndpointType.swift
//  DevKit
//
//  Created by Vladyslav Gusakov on 5/13/19.
//  Copyright © 2019 Vladyslav Gusakov. All rights reserved.
//

import Foundation

public protocol EndpointType {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders? { get }
}

class UserEndpoint: EndpointType {
    var baseURL: URL = URL(string: "")!
    
    var path: String = ""
    
    var httpMethod: HTTPMethod = .get
    
    var task: HTTPTask = .request(bodyParameters: ["test": 1], urlParameters: ["1234": "tezzt"], additionalHeaders: nil)
    
    var headers: HTTPHeaders? = nil
}
