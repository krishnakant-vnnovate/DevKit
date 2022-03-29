//
//  Money+Comparing.swift
//  DevKit
//
//  Created by Vladyslav Gusakov on 5/16/19.
//  Copyright © 2019 Vladyslav Gusakov. All rights reserved.
//

import Foundation

extension Money: Equatable {
    public static func == (lhs: Money, rhs: Money) -> Bool {
        return lhs.decimal == rhs.decimal
    }
}

extension Money: Comparable {
    public static func < (lhs: Money, rhs: Money) -> Bool {
        return lhs.decimal < rhs.decimal
    }
}

extension Money: Hashable {
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(decimal)
    }
    
}
