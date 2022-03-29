//
//  NetworkError.swift
//  DevKit
//
//  Created by Vladyslav Gusakov on 5/13/19.
//  Copyright © 2019 Vladyslav Gusakov. All rights reserved.
//

import Foundation

public enum NetworkError: Error {
    case missingURL
    case invalidURL
    case encodingFailed
    case requestFailed(Error)
    case internalError
}
