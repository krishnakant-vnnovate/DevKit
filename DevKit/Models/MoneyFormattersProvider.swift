//
//  MoneyFormattersProvider.swift
//  DevKit
//
//  Created by Vladyslav Gusakov on 5/16/19.
//  Copyright © 2019 Vladyslav Gusakov. All rights reserved.
//

import Foundation

class MoneyFormattersProvider {
    public typealias CurrencyCode = String
    
    private var formatters: [CurrencyCode: NumberFormatter] = [:]
    private var fractionlessFormatters: [CurrencyCode: NumberFormatter] = [:]
    
    public func formatter(forCurrencyCode currencyCode: CurrencyCode) -> NumberFormatter {
        if let existingFormatter = formatters[currencyCode] {
            return existingFormatter
        }
        
        let formatter = buildFormatter(withCurrencyCode: currencyCode)
        formatters[currencyCode] = formatter
        
        return formatter
    }
    
    func fractionlessFormatter(forCurrencyCode currencyCode: CurrencyCode) -> NumberFormatter {
        if let existingFormatter = fractionlessFormatters[currencyCode] {
            return existingFormatter
        }
        
        let formatter = buildFormatter(withCurrencyCode: currencyCode)
        formatter.maximumFractionDigits = 0
        fractionlessFormatters[currencyCode] = formatter
        
        return formatter
    }
    
    let currencylessFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "en-US")
        formatter.numberStyle = .currency
        formatter.currencySymbol = ""
        return formatter
    }()
}

private extension MoneyFormattersProvider {
    
    func buildFormatter(withCurrencyCode currencyCode: CurrencyCode) -> NumberFormatter {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "en-US")
        formatter.numberStyle = .currency
        formatter.currencyCode = currencyCode
        
        return formatter
    }
}

