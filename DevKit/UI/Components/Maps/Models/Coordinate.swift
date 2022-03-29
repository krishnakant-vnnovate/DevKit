//
//  Coordinate.swift
//  DevKit
//
//  Created by Vladyslav Gusakov on 5/5/19.
//  Copyright © 2019 Vladyslav Gusakov. All rights reserved.
//

import Foundation

public struct Coordinate: Codable, Equatable, Hashable {
    public let latitude: Double
    public let longitude: Double
    
    public init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}

public extension Coordinate {
    
    static var zero: Coordinate {
        return .init(latitude: 0, longitude: 0)
    }
}
