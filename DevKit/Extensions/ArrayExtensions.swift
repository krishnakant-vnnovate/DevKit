//
//  ArrayExtensions.swift
//  DevKit
//
//  Created by Vladyslav Gusakov on 5/5/19.
//  Copyright © 2019 Vladyslav Gusakov. All rights reserved.
//

import Foundation

public extension Swift.Collection {
    
    var hasElements: Bool {
        return !isEmpty
    }
    
}
public extension Array {
    
    mutating func remove(safeAt index: Index, function: String = #function, file: String = #file, line: Int = #line) {
        guard index >= 0 && index < count else {
            return
        }
        
        remove(at: index)
    }
    
    mutating func insert(_ element: Element, safeAt index: Index, function: String = #function, file: String = #file, line: Int = #line) {
        guard index >= 0 && index <= count else {
            return
        }
        
        insert(element, at: index)
    }
    
    subscript (safe index: Index) -> Element? {
        get {
            return indices.contains(index) ? self[index] : nil
        }
        set {
            remove(safeAt: index)
            
            if let element = newValue {
                insert(element, safeAt: index)
            }
        }
    }
    
    func appending(contentsOf newElements: [Element]) -> [Element] {
        var newArray: [Element] = []
        newArray.append(contentsOf: self)
        newArray.append(contentsOf: newElements)
        return newArray
    }
    
    func leftAndRight(of conditional: (Iterator.Element) -> Bool) -> (left: [Iterator.Element], right: [Iterator.Element])? {
        guard let indexOf = firstIndex(where: conditional) else { return nil }
        let next                = index(after: indexOf)
        let left                = Array(self[startIndex..<indexOf])
        let right               = Array(self[next..<endIndex])
        return (left: left, right: right)
    }
    
    func splitIntoSubarrays(ofSize size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            return Array(self[$0..<Swift.min($0 + size, count)])
        }
    }
    
    func shiftedRight(by amount: Int = 1) -> [Element] {
        var amount = amount
        guard -count...count ~= amount else { return self }
        
        if amount < 0 {
            amount += count
        }
        return Array(self[amount ..< count] + self[0 ..< amount])
    }
    
    static func + (left: Array, right: Element) -> Array {
        return left + [right]
    }
    
    static func + (left: Element, right: Array) -> Array {
        return [left] + right
    }
}

public extension Array where Element: Equatable {
    
    mutating func removeElement(_ element: Element) {
        self = filter { $0 != element }
    }
    
}

public extension Optional where Wrapped: Swift.Collection {
    
    var hasElements: Bool {
        return !isEmpty
    }
    
    var isEmpty: Bool {
        return self?.isEmpty ?? true
    }
}

// MARK: - Debug helpers
public extension Swift.Collection {
    
    var asJson: String {
        guard let jsonData = try? JSONSerialization.data(withJSONObject: self, options: [.prettyPrinted]),
            let jsonString = String(data: jsonData, encoding: .utf8) else {
                return "{}"
        }
        return jsonString as String
    }
}

