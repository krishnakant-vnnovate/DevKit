//
//  Coordinate+CoreLocation.swift
//  DevKit
//
//  Created by Vladyslav Gusakov on 5/5/19.
//  Copyright © 2019 Vladyslav Gusakov. All rights reserved.
//

import CoreLocation

extension Coordinate {
    
    public var clCoordinate: CLLocationCoordinate2D {
        return .init(latitude: latitude, longitude: longitude)
    }
    
    public var location: CLLocation {
        return .init(latitude: latitude, longitude: longitude)
    }
    
    public init(clCoordinate: CLLocationCoordinate2D) {
        self.init(latitude: clCoordinate.latitude, longitude: clCoordinate.longitude)
    }
    
    public func distance(from coordinate: Coordinate) -> Measurement<UnitLength> {
        let distanceInMeters = location.distance(from: coordinate.location)
        return .init(value: distanceInMeters, unit: .meters)
    }
}
