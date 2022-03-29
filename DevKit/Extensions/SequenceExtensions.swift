//
//  SequenceExtensions.swift
//  DevKit
//
//  Created by Vladyslav Gusakov on 5/5/19.
//  Copyright © 2019 Vladyslav Gusakov. All rights reserved.
//

import Foundation

extension Sequence {
    
    public func hashed<Key: Hashable>(by hashKeySelector: (Element) -> Key) -> [Key: Element] {
        var dictionary = [Key: Element]()
        for element in self {
            dictionary[hashKeySelector(element)] = element
        }
        
        return dictionary
    }
}
