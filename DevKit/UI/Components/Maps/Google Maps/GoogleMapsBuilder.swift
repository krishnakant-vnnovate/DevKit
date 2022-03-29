////
////  GoogleMapsBuilder.swift
////  DevKit
////
////  Created by Vladyslav Gusakov on 5/5/19.
////  Copyright © 2019 Vladyslav Gusakov. All rights reserved.
////
//
//import GoogleMaps
//
//class GoogleMapsBuilder {
//    
//    private let coordinate: Coordinate
//    
//    var mapView: GMSMapView {
//        let mapView = GMSMapView(frame: .zero)
//        mapView.settings.indoorPicker = false
//        let marker = GMSMarker(position: coordinate.clCoordinate)
//        mapView.mapType = .normal
//        marker.map = mapView
//        marker.appearAnimation = .pop
//        mapView.animate(with: GMSCameraUpdate.setTarget(coordinate.clCoordinate, zoom: 16))
//        
//        return mapView
//    }
//    
//    init(coordinate: Coordinate) {
//        self.coordinate = coordinate
//    }
//}
