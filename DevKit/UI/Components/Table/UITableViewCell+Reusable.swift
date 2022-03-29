//
//  UITableViewCell+Reusable.swift
//  DevKit
//
//  Created by Vladyslav Gusakov on 5/5/19.
//  Copyright © 2019 Vladyslav Gusakov. All rights reserved.
//

import UIKit

extension UITableViewCell: Reusable {
    
}

extension UITableViewHeaderFooterView: Reusable {
    
}

extension UITableView {
    
    func register<T: UITableViewCell>(_: T.Type) {
        register(TableRegistration(for: T.self))
    }
    
    func register<T: UITableViewHeaderFooterView>(_: T.Type) {
        register(TableRegistration(for: T.self))
    }
}
