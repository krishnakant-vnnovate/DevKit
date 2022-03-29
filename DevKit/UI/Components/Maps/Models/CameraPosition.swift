//
//  CameraPosition.swift
//  DevKit
//
//  Created by Vladyslav Gusakov on 5/5/19.
//  Copyright © 2019 Vladyslav Gusakov. All rights reserved.
//

import Foundation

public struct CameraPosition {
    
    public enum ZoomLevel: Equatable {
        case street
        case city
        case country
        case custom(Double)
        
        public var googleMapsValue: Float {
            switch self {
            case .street:
                return 15
            case .city:
                return 10.5
            case .country:
                return 3.5
            case .custom(let zoomLevel):
                return Float(zoomLevel)
            }
        }
    }
    
    public let coordinate: Coordinate
    public let zoom: ZoomLevel
    
    public init(coordinate: Coordinate, zoom: ZoomLevel) {
        self.coordinate = coordinate
        self.zoom = zoom
    }
}

public extension CameraPosition {
    
    static func street(coordinate: Coordinate) -> CameraPosition {
        return .init(coordinate: coordinate, zoom: .street)
    }
    
    static func city(coordinate: Coordinate) -> CameraPosition {
        return .init(coordinate: coordinate, zoom: .city)
    }
    
    static var country: CameraPosition {
        let coordinate = Coordinate(latitude: 39.8283, longitude: -98.5795)
        return .init(coordinate: coordinate, zoom: .country)
    }
    
    static func custom(coordinate: Coordinate, value: Float) -> CameraPosition {
        return .init(coordinate: coordinate, zoom: .custom(Double(value)))
    }
    
}

extension CameraPosition: Equatable {
    public static func == (lhs: CameraPosition, rhs: CameraPosition) -> Bool {
        return lhs.zoom == rhs.zoom && lhs.coordinate == rhs.coordinate
    }
}

extension CameraPosition.ZoomLevel: Comparable {
    
    public static func == (lhs: CameraPosition.ZoomLevel, rhs: CameraPosition.ZoomLevel) -> Bool {
        return lhs.googleMapsValue == rhs.googleMapsValue
    }
    
    public static func < (lhs: CameraPosition.ZoomLevel, rhs: CameraPosition.ZoomLevel) -> Bool {
        return lhs.googleMapsValue < rhs.googleMapsValue
    }
    
}
