//
//  DictionaryExtensions.swift
//  DevKit
//
//  Created by Vladyslav Gusakov on 5/16/19.
//  Copyright © 2019 Vladyslav Gusakov. All rights reserved.
//

import Foundation

extension Dictionary where Value == Any {
    public var removingNullValues: [Key: Value] {
        return removeNullValues()
    }
    
    public func removeNullValues() -> [Key: Value] {
        return compactMapValues { JSONParser.removeNull($0) }
    }
}

extension Array {
    public func removeNullValues() -> [Element] {
        return compactMap { JSONParser.removeNull($0) }
    }
}
