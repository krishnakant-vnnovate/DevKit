//
//  Money+Math.swift
//  DevKit
//
//  Created by Vladyslav Gusakov on 5/16/19.
//  Copyright © 2019 Vladyslav Gusakov. All rights reserved.
//

import Foundation

extension Money {
    
    public static func + (left: Money, right: Money) -> Money {
        let sum = left.decimal + right.decimal
        return Money(sum)
    }
    
    public static func - (left: Money, right: Money) -> Money {
        let sum = left.decimal - right.decimal
        return Money(sum)
    }
    
    public static func / (lhs: Money, rhs: Money) -> NSDecimalNumber {
        return (lhs.decimal / rhs.decimal) as NSDecimalNumber
    }
    
    public static prefix func - (amount: Money) -> Money {
        return Money(-amount.decimal)
    }
    
    public static func * (money: Money, multiplier: Decimal) -> Money {
        return Money(money.decimal * multiplier)
    }
    
    public static func * (multiplier: Decimal, money: Money) -> Money {
        return money * multiplier
    }
}
