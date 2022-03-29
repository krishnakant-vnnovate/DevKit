//
//  Location.swift
//  DevKit
//
//  Created by Vladyslav Gusakov on 5/5/19.
//  Copyright © 2019 Vladyslav Gusakov. All rights reserved.
//

import Foundation

public struct Location {
    public let name: String
    public let coordinate: Coordinate
    public let address: String
    
    public init(name: String, coordinate: Coordinate, address: String) {
        self.name = name
        self.coordinate = coordinate
        self.address = address
    }
}
