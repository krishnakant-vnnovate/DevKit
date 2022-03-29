//
//  UIControl+NibLoadable.swift
//  DevKit
//
//  Created by Vladyslav Gusakov on 5/17/19.
//  Copyright © 2019 Vladyslav Gusakov. All rights reserved.
//

import UIKit

extension NibLoadable where Self: UIControl {
    
    func loadNibContent() {
        for case let control as UIControl in type(of: self).nib.instantiate(withOwner: self, options: nil) {
            addSubview(control)
            control.backgroundColor = .clear
            control.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        }
    }
}
