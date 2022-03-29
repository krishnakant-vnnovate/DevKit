//
//  MapViewInterface.swift
//  DevKit
//
//  Created by Vladyslav Gusakov on 5/5/19.
//  Copyright © 2019 Vladyslav Gusakov. All rights reserved.
//

import Foundation

public typealias IdleAtCameraPositionHandler = ((CameraPosition) -> Void)
public typealias DidChangeCameraPositionHandler = ((CameraPosition) -> Void)
public typealias DidTapAtCoordinateHandler = ((Coordinate) -> Void)

public protocol MapViewInterface: class {
    var centerCoordinate: Coordinate { get }
    
    func setCameraPosition(_ cameraPosition: CameraPosition, animated: Bool)
    func setZoomLevelAnimated(_ zoom: CameraPosition.ZoomLevel)
    func setIsTrackingUserLocation(_ isTrackingLocation: Bool)
    func showDefaultMyLocationButton(_ show: Bool)
    func setAccessibilityIdentifier(_ accessibilityIdentifier: String)
    func configure(with map: Map, idleAtCameraPosition: IdleAtCameraPositionHandler?, didChangeCameraPosition: DidChangeCameraPositionHandler?, didTapAtCoordinate: DidTapAtCoordinateHandler?)
    func setAdjustPadding(_ adjustPadding: Bool)
    func coordinateForTopEdge() -> Coordinate
    func coordinateForBottomEdge() -> Coordinate
    func shortestDistanceToEdge(from coordinate: Coordinate) -> Measurement<UnitLength>
    func visibleVerticalDistance() -> Measurement<UnitLength>
    func setCameraPosition(to cameraPosition: CameraPosition, animated: Bool, offset: CGPoint)
}
