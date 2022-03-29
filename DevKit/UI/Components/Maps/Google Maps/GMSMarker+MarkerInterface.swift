////
////  GMSMarker+MarkerInterface.swift
////  DevKit
////
////  Created by Vladyslav Gusakov on 5/5/19.
////  Copyright © 2019 Vladyslav Gusakov. All rights reserved.
////
//
//import UIKit
//import GoogleMaps
//
//extension GMSMarker: MarkerInterface {
//    
//    public var mapView: MapViewInterface? {
//        get {
//            return map
//        }
//        set {
//            map = newValue as? GMSMapView
//        }
//    }
//    
//    public func configure(with viewModel: MarkerViewModel) {
//        position = viewModel.coordinate.clCoordinate
//        zIndex = Int32(viewModel.zIndex)
//        
//        clear()
//        
//        switch viewModel.type {
//        case .custom(let view):
//            iconView = view
//        case .image(let icon):
//            self.icon = icon
//        case .default(let title):
//            self.title = title
//        }
//    }
//    
//    private func clear() {
//        title = nil
//        icon = nil
//        iconView = nil
//    }
//}
