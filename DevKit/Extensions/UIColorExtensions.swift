//
//  UIColorExtensions.swift
//  DevKit
//
//  Created by Vladyslav Gusakov on 5/5/19.
//  Copyright © 2019 Vladyslav Gusakov. All rights reserved.
//

import UIKit

public let kDefaultPercentage: CGFloat = 10.0

public extension UIColor {
    
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat = 1) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: a)
    }
    
    convenience init(hex: Int, alpha: CGFloat = 1) {
        self.init(r: CGFloat((hex >> 16) & 0xff), g: CGFloat((hex >> 08) & 0xff), b: CGFloat((hex >> 00) & 0xff), a: alpha)
    }
    
    func blend(with color: UIColor, amount: CGFloat) -> UIColor {
        if color == .clear { return color }
        let a = CGFloat(min(1.0, max( 0.0, Double(amount))))
        let firstColorAmount: CGFloat = CGFloat(1.0) - a
        
        var r1: CGFloat = 0.0
        var g1: CGFloat = 0.0
        var b1: CGFloat = 0.0
        var a1: CGFloat = 0.0
        
        var r2: CGFloat = 0.0
        var g2: CGFloat = 0.0
        var b2: CGFloat = 0.0
        var a2: CGFloat = 0.0
        
        getRed(&r1, green: &g1, blue: &b1, alpha:&a1)
        color.getRed(&r2, green: &g2, blue: &b2, alpha:&a2)
        
        let red     = r1 * firstColorAmount + r2 * a
        let green   = g1 * firstColorAmount + g2 * a
        let blue    = b1 * firstColorAmount + b2 * a
        let alpha   = a1 * firstColorAmount + a2 * a
        
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    func lighter(_ percentage: CGFloat = kDefaultPercentage) -> UIColor? {
        return adjust(abs(percentage) )
    }
    
    func darker(_ percentage: CGFloat = kDefaultPercentage) -> UIColor? {
        return adjust(-1.0 * abs(percentage) )
    }
    
    func adjust(_ percentage: CGFloat) -> UIColor? {
        let truePercentage = clamp(value: percentage, lower: 0, upper: 100)
        
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        if getRed(&r, green: &g, blue: &b, alpha: &a) {
            return UIColor(red: min(r + truePercentage/100, 1.0),
                           green: min(g + truePercentage/100, 1.0),
                           blue: min(b + truePercentage/100, 1.0),
                           alpha: a)
        } else {
            return nil
        }
    }
    
    var selected: UIColor {
        return blend(with: .black, amount: 0.3)
    }
    
    var highlighted: UIColor {
        return blend(with: .white, amount: 0.3)
    }
    
    var disabled: UIColor {
        return withAlphaComponent(0.3)
    }
    
    var dimmed: UIColor {
        return withAlphaComponent(0.7)
    }
    
    var toHexString: String {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        
        return String(
            format: "#%02X%02X%02X",
            Int(r * 0xff),
            Int(g * 0xff),
            Int(b * 0xff)
        )
    }
    
    static func hexStringToUIColor(hex: String) -> UIColor {
        var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if cString.hasPrefix("#") {
            cString.remove(at: cString.startIndex)
        }
        
        if cString.count == 6 {
            var rgbValue: UInt32 = 0
            Scanner(string: cString).scanHexInt32(&rgbValue)
            
            return UIColor(
                red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                alpha: CGFloat(1.0)
            )
        } else if cString.count == 8 {
            
            var rgbValue: UInt32 = 0
            Scanner(string: cString).scanHexInt32(&rgbValue)
            
            return UIColor(
                red: CGFloat((rgbValue & 0x00FF0000) >> 16) / 255.0,
                green: CGFloat((rgbValue & 0x0000FF00) >> 8) / 255.0,
                blue: CGFloat(rgbValue & 0x000000FF) / 255.0,
                alpha: CGFloat((rgbValue & 0xFF000000) >> 24) / 255.0
            )
        } else {
            return UIColor.gray
        }
    }
    
    static var cgClear: UIColor = UIColor.white.withAlphaComponent(0)
}

// 🗜ing for everyone
public func clamp<T: Comparable>(value: T, lower: T, upper: T) -> T {
    return min(max(value, lower), upper)
}
