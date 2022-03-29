////
////  MapViewBuilder.swift
////  DevKit
////
////  Created by Vladyslav Gusakov on 5/5/19.
////  Copyright © 2019 Vladyslav Gusakov. All rights reserved.
////
//
//import GoogleMaps
//
//public class MapViewBuilder: MapViewBuilding {
//    
//    public let type: MapViewType
//    
//    public init(type: MapViewType) {
//        self.type = type
//    }
//    
//    public func mapView(centeredAt coordinate: Coordinate) -> MapView {
//        switch type {
//        case .googleMaps:
//            return buildGoogleMapsView(centeredAt: coordinate)
//        }
//    }
//    
//    public func marker() -> MarkerInterface {
//        switch type {
//        case .googleMaps:
//            return GMSMarker()
//        }
//    }
//}
//
//private extension MapViewBuilder {
//    
//    func buildGoogleMapsView(centeredAt coordinate: Coordinate) -> GMSMapView {
//        return GoogleMapsBuilder(coordinate: coordinate).mapView
//    }
//}
