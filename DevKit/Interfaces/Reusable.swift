//
//  Reusable.swift
//  DevKit
//
//  Created by Vladyslav Gusakov on 5/5/19.
//  Copyright © 2019 Vladyslav Gusakov. All rights reserved.
//

import UIKit

public protocol Reusable: class {
    static var reuseIdentifier: String { get }
    static var nib: UINib? { get }
}

extension Reusable {
    
    public static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    public static var nib: UINib? {
        let bundle = Bundle(for: self)
        let nibName = String(describing: self)
        
        if bundle.path(forResource: nibName, ofType: "nib") != nil {
            return UINib(nibName: nibName, bundle: bundle)
        } else {
            return nil
        }
    }
}
