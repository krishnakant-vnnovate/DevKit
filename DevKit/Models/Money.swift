//
//  Money.swift
//  DevKit
//
//  Created by Vladyslav Gusakov on 5/16/19.
//  Copyright © 2019 Vladyslav Gusakov. All rights reserved.
//

import Foundation

public struct Money: Codable {
    
    public let decimal: Decimal
    public private(set) var currencyCode = "USD"
    
    enum CodingKeys: String, CodingKey {
        case decimal = "value"
        case currencyCode = "currency"
    }
    
    public static let zero = Money(0)
    public static let infinity = Money(NSDecimalNumber.maximum.decimalValue)
    
    private static let formattersProvider = MoneyFormattersProvider()
    
    // MARK: - Getters
    public var doubleValue: Double {
        return NSDecimalNumber(decimal: self.decimal).doubleValue
    }
    
    public var localizedString: String {
        return Money.formattersProvider.formatter(forCurrencyCode: currencyCode).string(from: decimal as NSNumber) ?? ""
    }
    
    public var localizedStringWithoutCurrency: String {
        return Money.formattersProvider.currencylessFormatter.string(from: decimal as NSNumber) ?? ""
    }
    
    public var localizedCleanestString: String {
        let num = decimal as NSNumber
        if num.doubleValue - floor(num.doubleValue) == 0 {
            return Money.formattersProvider.fractionlessFormatter(forCurrencyCode: currencyCode).string(from: num) ?? ""
        } else {
            return Money.formattersProvider.formatter(forCurrencyCode: currencyCode).string(from: num) ?? ""
        }
    }
    
    // MARK: - init
    public init?(string: String) {
        guard let decimal = Money.formattersProvider.currencylessFormatter.number(from: string)?.decimalValue else {
            return nil
        }
        
        self.decimal = decimal
    }
    
    public init(_ decimal: Decimal) {
        self.decimal = decimal
    }
    
    public init(_ decimal: Decimal, currencyCode: String) {
        self.decimal = decimal
        self.currencyCode = currencyCode
    }
    
    public init(_ double: Double) {
        self.decimal = double.decimalValue
    }
    
    public init(_ int: Int) {
        self.decimal = Decimal(int)
    }
    
    public init(from decoder: Decoder) throws {
        if let singleValueContainer = try? decoder.singleValueContainer() {
            if let number = try? singleValueContainer.decode(Decimal.self) {
                self.init(number)
                return
            }
            if let string = try? singleValueContainer.decode(String.self),
                let money = Money(string: string) {
                self = money
                return
            }
        }
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let decimal = try container.decode(Decimal.self, forKey: .decimal)
        let currencyCode = try container.decode(String.self, forKey: .currencyCode)
        self.init(decimal, currencyCode: currencyCode)
        
    }
    
    public var isZero: Bool {
        return self.decimal.isZero
    }
    
    public static var 🌿: Money {
        return Money(4.20)
    }
    
}

// MARK: - convenience conversions
extension Double {
    
    var decimalValue: Decimal {
        var doubleCopy = Decimal(self)
        var endDecimal = Decimal()
        NSDecimalRound(&endDecimal, &doubleCopy, 2, NSDecimalNumber.RoundingMode.plain)
        return endDecimal
    }
    
}

extension Decimal {
    
    public var money: Money {
        return Money(self)
    }
}

extension NSDecimalNumber {
    
    public var money: Money {
        return Money(self as Decimal)
    }
}

extension Money {
    
    public var nsdecimalnumber: NSDecimalNumber {
        return self.decimal as NSDecimalNumber
    }
}

extension Money: ExpressibleByIntegerLiteral, ExpressibleByFloatLiteral {
    
    public init(integerLiteral value: Int) {
        self.init(value)
    }
    
    public init(floatLiteral value: Double) {
        self.init(value)
    }
    
}
