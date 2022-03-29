//
//  ParameterEncoder.swift
//  DevKit
//
//  Created by Vladyslav Gusakov on 5/13/19.
//  Copyright © 2019 Vladyslav Gusakov. All rights reserved.
//

import Foundation

public protocol ParameterEncoder {
    func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws
}
