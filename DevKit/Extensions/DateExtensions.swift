//
//  DateExtensions.swift
//  DevKit
//
//  Created by Vladyslav Gusakov on 5/16/19.
//  Copyright © 2019 Vladyslav Gusakov. All rights reserved.
//

import Foundation

infix operator --: MultiplicationPrecedence
public func -- (date1: Date, date2: Date) -> TimeInterval {
    return date1.timeIntervalSince1970 - date2.timeIntervalSince1970
}

extension Date {

    public func years(from date: Date) -> Int {
        return Calendar.current.dateComponents([.year], from: date, to: self).year ?? 0
    }
    
    public func months(from date: Date) -> Int {
        return Calendar.current.dateComponents([.month], from: date, to: self).month ?? 0
    }
    
    public func hoursFromNow(hours: TimeInterval) -> Date {
        let d = Date()
        let hoursAsSeconds = hours * 60.0 * 60.0
        return d.addingTimeInterval(hoursAsSeconds)
    }
    
    static public func fromString(_ dateString: String) -> Date? {
        if dateString.contains("T") {
            return defaultFormatter.date(from: dateString)
        } else if dateString.contains("/") {
            return slashesFormatter.date(from: dateString)
        } else if dateString.contains("-") {
            return dashesFormatter.date(from: dateString)
        } else {
            return simpleFormatter.date(from: dateString)
        }
    }
    
    static public var defaultFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        return dateFormatter
    }()
    
    static public var simpleFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.dateFormat = "MMMM dd, yyyy"
        return dateFormatter
    }()
    
    static public var slashesFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter
    }()
    
    static public var dashesFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter
    }()
    
    public var toLongString: String {
        return Date.defaultFormatter.string(from: self)
    }
    
    public func timeLeft(untilDate: Date, threshold: TimeInterval) -> TimeInterval {
        let tInterval                   = untilDate.timeIntervalSince1970 - timeIntervalSince1970
        return threshold - tInterval
    }
    
    public static func hours(since date: Date) -> Double {
        let numberOfSecondsInOneHour = 3600.0
        let current = Date()
        let secondsSinceDate: Double = current.timeIntervalSince(date)
        return secondsSinceDate / numberOfSecondsInOneHour
    }
    
    public static func minutes(since date: Date) -> Double {
        let numberOfSecondsInOneMin = 60.0
        let current = Date()
        let secondsSinceDate: Double = current.timeIntervalSince(date)
        return secondsSinceDate / numberOfSecondsInOneMin
    }
    
    public static func date(withSlashes value: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter.date(from: value)
    }
    
    public static func date(withoutSlashes value: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMddyyyy"
        return dateFormatter.date(from: value)
    }
    
    public func toSlashesString() -> String {
        let dateFormatter           = DateFormatter()
        dateFormatter.dateFormat    = "MM/dd/yyyy"
        return dateFormatter.string(from: self)
    }
    
    public func toShortString() -> String {
        let dateFormatter           = DateFormatter()
        dateFormatter.dateFormat    = "MMM d"
        return dateFormatter.string(from: self)
    }
    
    public func toYearMonthString() -> String {
        return DateFormatter.monthYearFormatter.string(from: self)
    }
    
    public func toDashesString() -> String {
        let dateFormatter           = DateFormatter()
        dateFormatter.dateFormat    = "yyyy-MM-dd"
        return dateFormatter.string(from: self)
    }
    
    public func toSimpleString() -> String {
        return Date.simpleFormatter.string(from: self)
    }
    
    public var longUserFriendlyString: String {
        return DateFormatter.userFriendlyLongFormatter.string(from: self)
    }
    
    public var isOver18: Bool {
        guard let yearsAgo = Calendar.current.date(byAdding: .year, value: -18, to: Date()) else { return false }
        let result = yearsAgo.compare(self)
        return result == .orderedDescending || result == .orderedSame
    }
    
    public var toJSONString: String {
        let dateFormatter           = DateFormatter()
        dateFormatter.dateFormat    = "yyyy-MM-dd"
        return dateFormatter.string(from: self)
    }
    
    public var isLaterThanToday: Bool {
        let now = Date()
        return !(self.compare(now) == .orderedAscending && !Calendar.current.isDateInToday(self))
    }
    
    public var shortMonthAndDay: String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = .current
        dateFormatter.setLocalizedDateFormatFromTemplate("MMM d")
        return dateFormatter.string(from: self)
    }
    
    public var shortMonthAndYear: String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = .current
        dateFormatter.setLocalizedDateFormatFromTemplate("MMM yyyy")
        return dateFormatter.string(from: self)
    }
    
}

extension Sequence where Iterator.Element: NSDate {
    
    public func earliest() -> Date {
        return Date(timeIntervalSince1970: map { $0.timeIntervalSince1970 }
            .compactMap { $0 }
            .reduce(TimeInterval(Float.greatestFiniteMagnitude)) { $0 < $1 ? $0 : $1 })
    }
    public func latest() -> Date {
        return Date(timeIntervalSince1970: map { $0.timeIntervalSince1970 }
            .compactMap { $0 }
            .reduce(0) { $0 > $1 ? $0 : $1 })
    }
    
}

extension TimeInterval {
    
    var milliseconds: Double {
        return self / 1000.0
    }
    
}
