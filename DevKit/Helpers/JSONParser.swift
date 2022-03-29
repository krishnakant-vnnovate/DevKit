//
//  JSONParser.swift
//  DevKit
//
//  Created by Vladyslav Gusakov on 5/16/19.
//  Copyright © 2019 Vladyslav Gusakov. All rights reserved.
//

import Foundation

public typealias JSONDict = [String: Any]

public class JSONParser {
    private static let dateDecoder = ISO8601DateDecoder()
    
    public static func decode<T: Decodable>(_ type: T.Type, from data: Data, function: String = #function, file: String = #file, line: Int = #line) -> T? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .custom(dateDecoder.decode(from:))
        
        var decodedValue: T?
        
        do {
            decodedValue = try decoder.decode(type, from: data)
        } catch {
            print(error)
        }
        
        return decodedValue
    }
    
    public static func decode<T: Decodable>(_ type: T.Type, from json: JSONObject, function: String = #function, file: String = #file, line: Int = #line) -> T? {
        guard let data = try? JSONSerialization.data(withJSONObject: json, options: []) else {
            return nil
        }
        return decode(type, from: data, function: function, file: file, line: line)
    }
    
    public static func encode<T: Encodable>(_ value: T, asSnakeCase: Bool, customDateFormatter: DateFormatter?) -> Data? {
        let encoder = JSONEncoder()
        
        if asSnakeCase {
            encoder.keyEncodingStrategy = .convertToSnakeCase
        }
        
        let dateFormatter = customDateFormatter ?? Date.defaultFormatter
        encoder.dateEncodingStrategy = .formatted(dateFormatter)
        
        encoder.outputFormatting = .prettyPrinted
        let encodedValue = try? encoder.encode(value)
        return encodedValue
    }
    
    public static func encodeToJSON<T: Encodable>(_ value: T, asSnakeCase: Bool, customDateFormatter: DateFormatter?) -> JSONObject? {
        guard let data = encode(value, asSnakeCase: asSnakeCase, customDateFormatter: customDateFormatter) else {
            return nil
        }
        
        if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
            return json
        }
        
        if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] {
            return json
        }
        
        return nil
    }
    
    public static func removeNull<T>(_ value: T) -> T? {
        switch value {
        case let dict as [String: Any]:
            return dict.removeNullValues() as? T
        case let array as [Any]:
            return array.removeNullValues() as? T
        case is NSNull:
            return nil
        default:
            return value
        }
    }
}

public protocol JSONObject {
    var dictionary: JSONDict? { get }
    var array: [JSONDict]? { get }
}

extension JSONObject {
    public var dictionary: JSONDict? {
        return self as? JSONDict
    }
    
    public var array: [JSONDict]? {
        return self as? [JSONDict]
    }
}

extension Dictionary: JSONObject where Key == String, Value == Any { }
extension Array: JSONObject where Element == JSONDict { }

public extension Decodable {
    
    static func decode(with jsonObject: JSONObject, function: String = #function, file: String = #file, line: Int = #line) -> Self? {
        return JSONParser.decode(Self.self, from: jsonObject, function: function, file: file, line: line)
    }
    
    static func decode(with data: Data, function: String = #function, file: String = #file, line: Int = #line) -> Self? {
        return JSONParser.decode(Self.self, from: data, function: function, file: file, line: line)
    }
}

public extension Encodable {
    
    func snakeCaseEncoded(withCustomDateFormatter customDateFormatter: DateFormatter? = nil) -> JSONObject? {
        return encoded(asSnakeCase: true, customDateFormatter: customDateFormatter)
    }
    
    func encoded(withCustomDateFormatter customDateFormatter: DateFormatter? = nil) -> JSONObject? {
        return encoded(asSnakeCase: false, customDateFormatter: customDateFormatter)
    }
    
    private func encoded(asSnakeCase: Bool, customDateFormatter: DateFormatter?) -> JSONObject? {
        return JSONParser.encodeToJSON(self, asSnakeCase: asSnakeCase, customDateFormatter: customDateFormatter)
    }
}
