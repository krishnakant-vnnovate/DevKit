//
//  DateFormatterExtensions.swift
//  DevKit
//
//  Created by Vladyslav Gusakov on 5/16/19.
//  Copyright © 2019 Vladyslav Gusakov. All rights reserved.
//

import Foundation

extension DateFormatter {
    
    public static let fullMonthFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM"
        
        return formatter
    }()
    
    public static let shortMonthFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM"
        
        return formatter
    }()
    
    public static let userFriendlyMediumFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeZone = .current
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        
        return formatter
    }()
    
    public static let userFriendlyLongFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeZone = .current
        formatter.dateFormat = "MMM d h:mm a zzz"
        
        return formatter
    }()
    
    public static let monthSlashYearFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/yy"
        
        return formatter
    }()
    
    public static let yearDashMonthFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        
        return formatter
    }()
    
    public static let defaultFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH: mm: ss.SSSZ"
        
        return formatter
    }()
    
    public static let monthYearFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM yyyy"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        
        return formatter
    }()
    
    public convenience init(dateFormat: String) {
        self.init()
        self.dateFormat = dateFormat
    }
    
}
