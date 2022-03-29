//
//  MapViewBuilding.swift
//  DevKit
//
//  Created by Vladyslav Gusakov on 5/5/19.
//  Copyright © 2019 Vladyslav Gusakov. All rights reserved.
//

import UIKit

public typealias MapView = UIView & MapViewInterface

public enum MapViewType: Equatable {
    case googleMaps
    
    public static var `default`: MapViewType {
        return .googleMaps
    }
}

public enum MarkerType {
    case custom(view: UIView)
    case image(icon: UIImage?)
    case `default`(title: String?)
}

public struct MarkerViewModel {
    public let coordinate: Coordinate
    public let type: MarkerType
    public let zIndex: Int
    
    public init(coordinate: Coordinate, type: MarkerType, zIndex: Int = 0) {
        self.coordinate = coordinate
        self.type = type
        self.zIndex = zIndex
    }
}

public protocol MapViewBuilding {
    var type: MapViewType { get }
    
    func mapView(centeredAt coordinate: Coordinate) -> MapView
    func marker() -> MarkerInterface
}
