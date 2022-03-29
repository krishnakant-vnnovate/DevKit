//
//  ISO8601DateDecoder.swift
//  DevKit
//
//  Created by Vladyslav Gusakov on 5/16/19.
//  Copyright © 2019 Vladyslav Gusakov. All rights reserved.
//

import Foundation

class ISO8601DateDecoder {
    private static let errorMessage = "Date is not in one of the supported formats."
    private static let formatters: [DateFormatting] = {
        let supportedFormats: [ISO8601Format] = [.dateTime, .date, .yearMonth]
        return ISO8601DateDecoder.oldFractionalFormatter + supportedFormats.map(formatter(from:))
    }()
    
    private static func formatter(from format: ISO8601Format) -> DateFormatting {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = format.options
        formatter.timeZone = format.timeZone
        
        return formatter
    }
    
    // Starting with iOS 11, ISO8601DateFormatter has a `withFractionalSeconds` option.
    // Once the minimum iOS version is bumped to 11, this custom formatter needs to be deleted
    // along with the DateFormatting protocol/conformance and a new option
    // [.withInternetDateTime, .withFractionalSeconds] prepended to the `supportedFormats`
    private static let oldFractionalFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        
        return formatter
    }()
    
    func decode(from decoder: Decoder) throws -> Date {
        let container = try decoder.singleValueContainer()
        let dateString = try container.decode(String.self)
        
        guard let date = ISO8601DateDecoder.formatters.reduce(nil, { $0 ?? $1.date(from: dateString) }) else {
            throw DecodingError.dataCorruptedError(in: container, debugDescription: ISO8601DateDecoder.errorMessage)
        }
        
        return date
    }
}

protocol DateFormatting {
    func date(from string: String) -> Date?
}

extension ISO8601DateFormatter: DateFormatting {
    
}

extension DateFormatter: DateFormatting {
    
}

