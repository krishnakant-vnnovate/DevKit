//
//  ForwardsCompatible+Array.swift
//  DevKit
//
//  Created by Vladyslav Gusakov on 5/21/19.
//  Copyright © 2019 Vladyslav Gusakov. All rights reserved.
//

import Foundation

public protocol KnownValueProviding {
    associatedtype KnownValue
    
    var knownValue: KnownValue? { get }
}

extension ForwardsCompatible: KnownValueProviding {
    
    public typealias KnownValue = T
    
    public var knownValue: T? {
        guard case let .known(t) = self else {
            return nil
        }
        
        return t
    }
}

extension Array where Element: KnownValueProviding {
    
    public var known: [Element.KnownValue] {
        return compactMap { $0.knownValue }
    }
}
