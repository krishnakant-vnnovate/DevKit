//
//  NavigationBarDecorating.swift
//  DevKit
//
//  Created by Vladyslav Gusakov on 5/5/19.
//  Copyright © 2019 Vladyslav Gusakov. All rights reserved.
//

import Foundation

public protocol NavigationBarDecorating: class {
    func configureNavigation(with viewModel: NavigationViewModel)
}
