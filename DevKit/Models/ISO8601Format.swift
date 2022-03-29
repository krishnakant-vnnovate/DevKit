//
//  ISO8601Format.swift
//  DevKit
//
//  Created by Vladyslav Gusakov on 5/16/19.
//  Copyright © 2019 Vladyslav Gusakov. All rights reserved.
//

import Foundation

struct ISO8601Format {
    let options: ISO8601DateFormatter.Options
    let timeZone: TimeZone?
}

extension ISO8601Format {
    
    static let dateTime = ISO8601Format(options: .dateTime, timeZone: TimeZone(secondsFromGMT: 0))
    static let date = ISO8601Format(options: .date, timeZone: .current)
    static let yearMonth = ISO8601Format(options: .yearMonth, timeZone: .current)
}
