//
//  Marker.swift
//  DevKit
//
//  Created by Vladyslav Gusakov on 5/5/19.
//  Copyright © 2019 Vladyslav Gusakov. All rights reserved.
//

import Foundation
import UIKit

// swiftlint:disable legacy_hashing
public protocol MarkerInterface {
    var hashValue: Int { get }
    var mapView: MapViewInterface? { get set }
    
    func configure(with viewModel: MarkerViewModel)
}

public protocol MarkerProviding {
    var marker: MarkerInterface { get }
}

public class MarkerWrapper: Hashable, MarkerProviding {
    
    public var marker: MarkerInterface
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(marker.hashValue)
    }
    
    public init(marker: MarkerInterface) {
        self.marker = marker
    }
    
    public static func == (lhs: MarkerWrapper, rhs: MarkerWrapper) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
}
