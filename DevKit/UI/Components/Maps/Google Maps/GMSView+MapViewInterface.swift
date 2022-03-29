////
////  GMSView+MapViewInterface.swift
////  DevKit
////
////  Created by Vladyslav Gusakov on 5/5/19.
////  Copyright © 2019 Vladyslav Gusakov. All rights reserved.
////
//
//import GoogleMaps
//
//extension GMSMapView: MapViewInterface {
//    
//    public var centerCoordinate: Coordinate {
//        return CameraPosition(gmsCameraPosition: camera).coordinate
//    }
//    
//    public func setCameraPosition(_ cameraPosition: CameraPosition, animated: Bool) {
//        let camera = GMSCameraPosition.camera(withTarget: cameraPosition.coordinate.clCoordinate, zoom: cameraPosition.zoom.googleMapsValue)
//        if animated {
//            animate(to: camera)
//        } else {
//            self.camera = camera
//        }
//    }
//    
//    public func setZoomLevelAnimated(_ zoom: CameraPosition.ZoomLevel) {
//        animate(toZoom: zoom.googleMapsValue)
//    }
//    
//    public func setIsTrackingUserLocation(_ isTrackingLocation: Bool) {
//        isMyLocationEnabled = isTrackingLocation
//    }
//    
//    public func showDefaultMyLocationButton(_ show: Bool) {
//        settings.myLocationButton = show
//    }
//    
//    public func setAccessibilityIdentifier(_ accessibilityIdentifier: String) {
//        superview?.accessibilityIdentifier = accessibilityIdentifier
//    }
//    
//    public func setAdjustPadding(_ adjustPadding: Bool) {
//        paddingAdjustmentBehavior = adjustPadding ? .always : .never
//    }
//}
