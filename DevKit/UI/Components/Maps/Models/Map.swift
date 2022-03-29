//
//  Map.swift
//  DevKit
//
//  Created by Vladyslav Gusakov on 5/5/19.
//  Copyright © 2019 Vladyslav Gusakov. All rights reserved.
//

import Foundation

public struct Map {
    
    public let items: [MarkerWrapper: Item]
    public let style: Style
    public let initialCameraPosition: CameraPosition?
    public let isUserInteractionEnabled: Bool
    
    public init(markers: [Item], style: Style = .default, initialCameraPosition: CameraPosition? = nil, isUserInteractionEnabled: Bool = true) {
        self.items = markers.hashed { $0.markerWrapper }
        self.style = style
        self.initialCameraPosition = initialCameraPosition
        self.isUserInteractionEnabled = isUserInteractionEnabled
    }
    
}

extension Map {
    
    public struct Item {
        
        var markerWrapper: MarkerWrapper
        public let representsCluster: Bool
        public let allowToCluster: Bool
        
        public var marker: MarkerInterface {
            return markerWrapper.marker
        }
        
        public var configure: ((MarkerInterface) -> Void)?
        public var didTap: ((MarkerInterface) -> Void)?
        public var didSelectWithClusterFirst: ((MarkerInterface) -> Void)?
        public var didSelectWithCluster: ((MarkerInterface) -> Void)?
        public var didSelectWithClusterLast: ((MarkerInterface) -> Void)?

        
        public init(builder: MapViewBuilding, representsCluster: Bool = false, allowToCluster: Bool = true) {
            self.markerWrapper = MarkerWrapper(marker: builder.marker())
            self.representsCluster = representsCluster
            self.allowToCluster = allowToCluster
        }
        
        public func setMap(_ map: MapView) {
            markerWrapper.marker.mapView = map
        }
        
    }
    
}

extension Map {
    
    public enum Style {
        case `default`
        case minimal
    }
    
}
