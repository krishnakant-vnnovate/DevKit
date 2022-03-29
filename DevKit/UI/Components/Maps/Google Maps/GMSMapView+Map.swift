////
////  GMSMapView+Map.swift
////  DevKit
////
////  Created by Vladyslav Gusakov on 5/5/19.
////  Copyright © 2019 Vladyslav Gusakov. All rights reserved.
////
//
//import GoogleMaps
//
//private var mapViewDelegateKey = "MapViewDelegate"
//
//extension GMSMapView {
//    
//    public func configure(with map: Map,
//                          idleAtCameraPosition: IdleAtCameraPositionHandler? = nil,
//                          didChangeCameraPosition: DidChangeCameraPositionHandler? = nil,
//                          didTapAtCoordinate: DidTapAtCoordinateHandler? = nil) {
//        clear()
//        
//        if let cameraPosition = map.initialCameraPosition {
//            moveCamera(.setTarget(cameraPosition.coordinate.clCoordinate, zoom: cameraPosition.zoom.googleMapsValue))
//        }
//        
//        isUserInteractionEnabled = map.isUserInteractionEnabled
//        
//        map.items.values.forEach { item in
//            item.configure?(item.marker)
//            item.setMap(self)
//        }
//        mapStyle = map.style.mapStyle
//        mapViewDelegate = MapViewDelegate(map: map)
//        mapViewDelegate?.idleAtCameraPosition = idleAtCameraPosition
//        mapViewDelegate?.didChangeCameraPosition = didChangeCameraPosition
//        mapViewDelegate?.didTapAtCoordinate = didTapAtCoordinate
//        delegate = mapViewDelegate
//    }
//    
//    private var mapViewDelegate: MapViewDelegate? {
//        get {
//            return objc_getAssociatedObject(self, &mapViewDelegateKey) as? MapViewDelegate
//        }
//        
//        set {
//            objc_setAssociatedObject(self, &mapViewDelegateKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
//        }
//    }
//    
//    public func coordinateForTopEdge() -> Coordinate {
//        let topCenterPoint = convert(CGPoint(x: frame.width / 2, y: 0), from: self)
//        let coordinate = Coordinate(clCoordinate: projection.coordinate(for: topCenterPoint))
//        return coordinate
//    }
//    
//    public func coordinateForBottomEdge() -> Coordinate {
//        let bottomCenterPoint = convert(CGPoint(x: frame.width / 2, y: frame.height), from: self)
//        let coordinate = Coordinate(clCoordinate: projection.coordinate(for: bottomCenterPoint))
//        return coordinate
//    }
//    
//    public func shortestDistanceToEdge(from coordinate: Coordinate) -> Measurement<UnitLength> {
//        let topCenterCoordinate = coordinateForTopEdge()
//        let radius = topCenterCoordinate.distance(from: coordinate)
//        return radius
//    }
//    
//    public func visibleVerticalDistance() -> Measurement<UnitLength> {
//        return coordinateForTopEdge().distance(from: coordinateForBottomEdge())
//    }
//}
