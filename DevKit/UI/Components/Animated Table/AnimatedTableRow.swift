//
//  AnimatedTableRow.swift
//  RentalsCA
//
//  Created by Vladyslav Gusakov on 6/16/19.
//  Copyright © 2019 RentalsCA. All rights reserved.
//

import UIKit

public struct AnimatedTableRow: TableRowInterface {
    public let reuseIdentifier: String
    public private(set) var registration: TableRegistration?
    public var diffIdentifier: String?
    
    public var configure: ((UITableView, UITableViewCell) -> Void)?
    public var didSelect: ((UITableView, IndexPath) -> Void)?
    public var willDisplay: ((UITableView, UITableViewCell, IndexPath) -> Void)?
    public var height: ((UITableView, IndexPath) -> CGFloat)?
    public var estimatedHeight: ((UITableView, IndexPath) -> CGFloat)?
    
    public init<T: UITableViewCell>(_: T.Type) {
        let registration = TableRegistration(for: T.self)
        self.registration = registration
        self.reuseIdentifier = registration.reuseIdentifier
    }
}

extension AnimatedTableRow: Hashable {
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(reuseIdentifier)
        hasher.combine(diffIdentifier)
    }
    
    public static func == (lhs: AnimatedTableRow, rhs: AnimatedTableRow) -> Bool {
        return lhs.reuseIdentifier == rhs.reuseIdentifier &&
            lhs.diffIdentifier == rhs.diffIdentifier
    }
}
