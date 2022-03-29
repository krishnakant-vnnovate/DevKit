//
//  StringExtensions.swift
//  DevKit
//
//  Created by Vladyslav Gusakov on 5/5/19.
//  Copyright © 2019 Vladyslav Gusakov. All rights reserved.
//

import UIKit

extension String {
    
    public func heightWithConstrainedWidth(_ width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        return ceil(boundingBox.height)
    }
    
    public func widthWithConstrainedHeight(_ height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: CGFloat.greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        return ceil(boundingBox.width)
    }
    
    public func image(_ complete: (UIImage?) -> Void) {
        guard let dataDecoded = Data(base64Encoded: self, options: .ignoreUnknownCharacters) else {
            complete(nil)
            return
        }
        complete(UIImage(data: dataDecoded))
    }
    
    public func attributedStyle(font: UIFont, textColor: UIColor, alignment: NSTextAlignment = .center) -> NSAttributedString {
        let style = Attributes().withFont(font).withForegroundColor(textColor).withAlignment(alignment)
        return NSAttributedString(string: self, attributes: style.attributes)
    }
    
    public var initialCap: String {
        guard let firstCharacter = first else { return self }
        return String(firstCharacter).uppercased() + String(dropFirst())
    }
    
    public static func randomStringWithLength(_ len: Int) -> NSString {
        let letters: NSString                = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let randomString: NSMutableString    = NSMutableString(capacity: len)
        for _ in 0..<len {
            let length                      = UInt32 (letters.length)
            let rand                        = arc4random_uniform(length)
            randomString.appendFormat("%C", letters.character(at: Int(rand)))
        }
        return randomString
    }
    
    public func formattedToPhoneNumber() -> String {
        if self.count < 10 { return self }
        let notPhoneNumbers = CharacterSet.decimalDigits.inverted
        let str = components(separatedBy: notPhoneNumbers).joined(separator: "")
        if str.count < 7 { return self }
        
        let startIdx = str.startIndex
        let endIdx = str.endIndex
        let off3 = str.index(startIdx, offsetBy: 3)
        let off6 = str.index(startIdx, offsetBy: 6)
        let count = str.count
        if count == 7 {
            return "\(str[startIdx..<off3])-\(str[off3..<endIdx])"
        } else if count == 10 {
            return "(\(str[startIdx..<str.index(startIdx, offsetBy: 3)]))\u{00a0}\(str[off3..<off6])-\(str[off6..<endIdx])"
        } else if count > 10 {
            let extra = str.count - 10
            return "+\(str[startIdx..<str.index(startIdx, offsetBy: extra)])(\(str[str.index(endIdx, offsetBy: -10)..<str.index(endIdx, offsetBy: -7)]))\(str[str.index(endIdx, offsetBy: -7)..<str.index(endIdx, offsetBy: -4)])-\(str[str.index(endIdx, offsetBy: -4)..<endIdx])"
        }
        return self
    }
    
    public func unformattedPhoneNumber() -> String {
        let notPhoneNumbers = CharacterSet(charactersIn: "0123456789").inverted
        return components(separatedBy: notPhoneNumbers).joined(separator: "")
    }
    
    public static func convertElevenDigitNumberToTenDigit(_ elevenDigit: String) -> String? {
        let unformattedVersion = elevenDigit.unformattedPhoneNumber()
        
        if unformattedVersion.count == 11,
            unformattedVersion.first == "1" {
            let startIndex = unformattedVersion.index(unformattedVersion.startIndex, offsetBy: 1)
            return String(unformattedVersion[startIndex..<unformattedVersion.endIndex])
        }
        
        return nil
    }
    
    public var toUIColor: UIColor {
        return UIColor.hexStringToUIColor(hex: self)
    }
    
    public func removingRegexMatches(pattern: String, replaceWith: String = "") -> String {
        do {
            let regex = try NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options.caseInsensitive)
            let range = NSRange(location: 0, length: self.count)
            return regex.stringByReplacingMatches(in: self, options: [], range: range, withTemplate: replaceWith)
        } catch {
            return self
        }
    }
    
    public var selfOrNilIfEmpty: String? {
        return self.isEmpty ? nil : self
    }
    
    public func containsAny(of substrings: [String]) -> Bool {
        return substrings.reduce(false) {
            $0 || self.contains($1)
        }
    }
    
    public func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        
        return ceil(boundingBox.height)
    }
    
    public func inserting(_ separator: String, every partLength: Int) -> String {
        let parts = Array(self).splitIntoSubarrays(ofSize: partLength)
        return String(parts.joined(separator: separator))
    }
    
    public var nonBreaking: String {
        return self.replacingOccurrences(of: String.space, with: String.nonBreakingSpace)
    }
    
    public var capitalizingFirstLetter: String {
        guard !isEmpty else { return self }
        return prefix(1).uppercased() + dropFirst()
    }
    
    public mutating func capitalizeFirstLetter() {
        self = capitalizingFirstLetter
    }
    
    public func withFootnote(numbered: SuperscriptNumber) -> String {
        return "\(self)\(numbered.asString)"
    }
    
    public func asFootnote(numbered: SuperscriptNumber) -> String {
        return "\(numbered.asString) \(self)"
    }
    
    public func repeated(times: Int) -> String {
        return Array(repeating: self, count: times).joined()
    }
    
    public static func percentage(withNumber number: Double, minFractionDigits: Int = 0, maxFractionDigits: Int = 0) -> String {
        let formattedNumber = number.string(minFractionDigits: minFractionDigits, maxFractionDigits: maxFractionDigits)
        return "\(formattedNumber)\(String.percent)"
    }
    
    public static let space = " "
    public static let bulletThin = "⋅"
    public static let bulletThick = "•"
    public static let newLine = "\n"
    public static let doubleNewLine = String.newLine.repeated(times: 2)
    public static let empty = ""
    public static let nonBreakingSpace = "\u{00a0}"
    public static let tabSpace = "\t"
    public static let pipe = "|"
    public static let superscript1 = "¹"
    public static let superscript2 = "²"
    public static let superscript3 = "³"
    public static let superscript4 = "⁴"
    public static let percent = "%"
    public static let semicolon = ";"
    public static let forwardSlash = "/"
}

extension NSString {
    
    public func heightWithConstrainedWidth(_ width: CGFloat, font: UIFont) -> CGFloat {
        return String(self).heightWithConstrainedWidth(width, font: font)
    }
    
    public func widthWithConstrainedHeight(_ height: CGFloat, font: UIFont) -> CGFloat {
        return String(self).widthWithConstrainedHeight(height, font: font)
    }
    
    public func formattedToPhoneNumber() -> NSString {
        return NSString(string: String(self).formattedToPhoneNumber())
    }
    
    public func unformattedPhoneNumber() -> NSString {
        return NSString(string: String(self).unformattedPhoneNumber())
    }
    
    public static func style(text: String, font: UIFont, textColor: UIColor, alignment: NSTextAlignment = .left) -> NSAttributedString {
        let style = Attributes().withFont(font).withForegroundColor(textColor).withAlignment(alignment)
        return NSAttributedString(string: text, attributes: style.attributes)
    }
    
}

extension NSAttributedString {
    
    public func heightWithConstrainedWidth(_ width: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, context: nil)
        return ceil(boundingBox.height)
    }
    
    public func widthWithConstrainedHeight(_ height: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: CGFloat.greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, context: nil)
        return ceil(boundingBox.width)
    }
    
}

public enum SuperscriptNumber {
    case one
    case two
    case three
    case four
    
    public var asString: String {
        switch self {
        case .one:
            return .superscript1
        case .two:
            return .superscript2
        case .three:
            return .superscript3
        case .four:
            return .superscript4
        }
    }
}
