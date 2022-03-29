//
//  ForwardsCompatible.swift
//  DevKit
//
//  Created by Vladyslav Gusakov on 5/21/19.
//  Copyright © 2019 Vladyslav Gusakov. All rights reserved.
//

import Foundation

public protocol VolatileDecodable: RawRepresentable & Decodable where RawValue == String { }

public enum ForwardsCompatible<T: VolatileDecodable>: Codable, Equatable {
    case known(T)
    case unknown(String)
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(String.self)
        
        self.init(rawValue: rawValue)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(rawValue)
    }
}

extension ForwardsCompatible {
    
    public static func == (left: ForwardsCompatible, right: T) -> Bool {
        guard case let .known(val) = left else {
            return false
        }
        
        return val.rawValue == right.rawValue
    }
}
