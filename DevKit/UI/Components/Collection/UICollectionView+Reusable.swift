//
//  UICollectionView+Reusable.swift
//  DevKit
//
//  Created by Vladyslav Gusakov on 5/5/19.
//  Copyright © 2019 Vladyslav Gusakov. All rights reserved.
//

import UIKit

extension UICollectionReusableView: Reusable {
    
}

extension UICollectionView {
    
    func register<T: UICollectionViewCell>(_: T.Type) {
        register(Registration(for: T.self))
    }
}
