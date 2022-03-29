//
//  ISO8601DateFormatterOptionsExtensions.swift
//  DevKit
//
//  Created by Vladyslav Gusakov on 5/16/19.
//  Copyright © 2019 Vladyslav Gusakov. All rights reserved.
//

import Foundation

extension ISO8601DateFormatter.Options {
    
    static let dateTime: ISO8601DateFormatter.Options = [.withInternetDateTime, .withColonSeparatorInTime, .withDashSeparatorInDate]
    static let date: ISO8601DateFormatter.Options = [.withFullDate, .withDashSeparatorInDate]
    static let yearMonth: ISO8601DateFormatter.Options = [.withYear, .withDashSeparatorInDate, .withMonth]
}
