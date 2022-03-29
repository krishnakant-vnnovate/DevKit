////
////  MapViewDelegate.swift
////  DevKit
////
////  Created by Vladyslav Gusakov on 5/5/19.
////  Copyright © 2019 Vladyslav Gusakov. All rights reserved.
////
//
//import GoogleMaps
//
//public class MapViewDelegate: NSObject, GMSMapViewDelegate {
//    
//    let map: Map
//    
//    var idleAtCameraPosition: IdleAtCameraPositionHandler?
//    var willMove: ((MapView) -> Void)?
//    var didChangeCameraPosition: DidChangeCameraPositionHandler?
//    var didTapAtCoordinate: ((Coordinate) -> Void)?
//    var didLongPressAtCoordinate: ((Coordinate) -> Void)?
//    
//    public init(map: Map) {
//        self.map = map
//    }
//    
//    public func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
//        let cameraPosition = CameraPosition(gmsCameraPosition: position)
//        idleAtCameraPosition?(cameraPosition)
//    }
//    
//    public func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
//        willMove?(mapView)
//    }
//    
//    public func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
//        let cameraPosition = CameraPosition(gmsCameraPosition: position)
//        didChangeCameraPosition?(cameraPosition)
//    }
//    
//    public func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
//        let coordinates = Coordinate(clCoordinate: coordinate)
//        didTapAtCoordinate?(coordinates)
//    }
//    
//    public func mapView(_ mapView: GMSMapView, didLongPressAt coordinate: CLLocationCoordinate2D) {
//        let coordinates = Coordinate(clCoordinate: coordinate)
//        didLongPressAtCoordinate?(coordinates)
//    }
//    
//    public func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
//        let markerWrapper = MarkerWrapper(marker: marker)
//        map.items[markerWrapper]?.didTap?(markerWrapper.marker)
//        return true
//    }
//}
