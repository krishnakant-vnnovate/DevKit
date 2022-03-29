//
//  ForwardsCompatible+RawRepresentable.swift
//  DevKit
//
//  Created by Vladyslav Gusakov on 5/21/19.
//  Copyright © 2019 Vladyslav Gusakov. All rights reserved.
//

import Foundation

extension ForwardsCompatible: RawRepresentable {
    
    public typealias RawValue = String
    
    public init(rawValue: String) {
        self = T(rawValue: rawValue).map { .known($0) } ?? .unknown(rawValue)
    }
    
    public var rawValue: RawValue {
        switch self {
        case let .known(t):
            return t.rawValue
        case let .unknown(string):
            return string
        }
    }
}

