//
//  MapContainerView.swift
//  DevKit
//
//  Created by Vladyslav Gusakov on 5/5/19.
//  Copyright © 2019 Vladyslav Gusakov. All rights reserved.
//

import UIKit

public class MapContainerView: UIView {
    
    public var mapView: MapView? {
        didSet {
            removeMapView()
            mapView.map { addMapView($0) }
        }
    }
    
    private func addMapView(_ mapView: MapView) {
        addSubview(mapView)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        mapView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        mapView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        mapView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        mapView.setNeedsLayout()
        mapView.layoutIfNeeded()
    }
    
    private func removeMapView() {
        mapView?.removeFromSuperview()
    }
    
}

extension MapContainerView: MapViewInterface {
    
    public var centerCoordinate: Coordinate {
        return mapView?.centerCoordinate ?? .zero
    }
    
    public func setCameraPosition(_ cameraPosition: CameraPosition, animated: Bool) {
        mapView?.setCameraPosition(cameraPosition, animated: animated)
    }
    
    public func setZoomLevelAnimated(_ zoom: CameraPosition.ZoomLevel) {
        mapView?.setZoomLevelAnimated(zoom)
    }
    
    public func setIsTrackingUserLocation(_ isTrackingLocation: Bool) {
        mapView?.setIsTrackingUserLocation(isTrackingLocation)
    }
    
    public func showDefaultMyLocationButton(_ show: Bool) {
        mapView?.showDefaultMyLocationButton(show)
    }
    
    public func setAccessibilityIdentifier(_ accessibilityIdentifier: String) {
        mapView?.setAccessibilityIdentifier(accessibilityIdentifier)
    }
    
    public func configure(with map: Map,
                          idleAtCameraPosition: IdleAtCameraPositionHandler? = nil,
                          didChangeCameraPosition: DidChangeCameraPositionHandler? = nil,
                          didTapAtCoordinate: DidTapAtCoordinateHandler? = nil) {
        mapView?.configure(with: map, idleAtCameraPosition: idleAtCameraPosition, didChangeCameraPosition: didChangeCameraPosition, didTapAtCoordinate: didTapAtCoordinate)
    }
    
    public func setAdjustPadding(_ adjustPadding: Bool) {
        mapView?.setAdjustPadding(adjustPadding)
    }
    
    public func coordinateForTopEdge() -> Coordinate {
        let topEdgeCoordinate = mapView?.coordinateForTopEdge()
        return topEdgeCoordinate ?? .zero
    }
    
    public func coordinateForBottomEdge() -> Coordinate {
        return mapView?.coordinateForBottomEdge() ?? .zero
    }
    
    public func shortestDistanceToEdge(from coordinate: Coordinate) -> Measurement<UnitLength> {
        return mapView?.shortestDistanceToEdge(from: coordinate) ?? .init(value: 0, unit: .meters)
    }
    
    public func visibleVerticalDistance() -> Measurement<UnitLength> {
        return mapView?.visibleVerticalDistance() ?? .init(value: 0, unit: .meters)
    }
    
    public func setCameraPosition(to cameraPosition: CameraPosition, animated: Bool, offset: CGPoint) {
        mapView?.setCameraPosition(to: cameraPosition, animated: animated, offset: offset)
    }
}
