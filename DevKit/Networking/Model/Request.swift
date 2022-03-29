//
//  Request.swift
//  DevKit
//
//  Created by Vladyslav Gusakov on 5/14/19.
//  Copyright © 2019 Vladyslav Gusakov. All rights reserved.
//

import Foundation

public struct Request {
    public let path: String
    public let method: HTTPMethod
    public let parameters: Parameters
    public let headers: HTTPHeaders
}
