//
//  Table.swift
//  DevKit
//
//  Created by Vladyslav Gusakov on 5/5/19.
//  Copyright © 2019 Vladyslav Gusakov. All rights reserved.
//

import UIKit

public protocol TableRowInterface {
    var reuseIdentifier: String { get }
    var registration: TableRegistration? { get }
    
    var configure: ((UITableView, UITableViewCell) -> Void)? { get set }
    var didSelect: ((UITableView, IndexPath) -> Void)? { get set }
    var willDisplay: ((UITableView, UITableViewCell, IndexPath) -> Void)? { get set }
    var height: ((UITableView, IndexPath) -> CGFloat)? { get set }
    var estimatedHeight: ((UITableView, IndexPath) -> CGFloat)? { get set }
    
    init<T: UITableViewCell>(_ type: T.Type)
}

public struct TableRow: TableRowInterface {
    public let reuseIdentifier: String
    public private(set) var registration: TableRegistration?
    
    public var configure: ((UITableView, UITableViewCell) -> Void)?
    public var didSelect: ((UITableView, IndexPath) -> Void)?
    public var willDisplay: ((UITableView, UITableViewCell, IndexPath) -> Void)?
    public var height: ((UITableView, IndexPath) -> CGFloat)?
    public var estimatedHeight: ((UITableView, IndexPath) -> CGFloat)?
    
    public init(reuseIdentifier: String) {
        self.reuseIdentifier = reuseIdentifier
    }
    
    public init<T: UITableViewCell>(_: T.Type) {
        let registration = TableRegistration(for: T.self)
        self.registration = registration
        self.reuseIdentifier = registration.reuseIdentifier
    }
}

public struct TableSection {
    public let header: TableSectionHeaderFooter?
    public let footer: TableSectionHeaderFooter?
    public let rows: [TableRow]
    
    public var height: ((UITableView, Int) -> CGFloat)?
    
    public init(rows: [TableRow], header: TableSectionHeaderFooter? = nil, footer: TableSectionHeaderFooter? = nil) {
        self.header = header
        self.rows = rows
        self.footer = footer
    }
}

public struct TableSectionHeaderFooter {
    public let reuseIdentifier: String
    public private(set) var registration: TableRegistration?
    
    public var configure: ((UITableViewHeaderFooterView) -> Void)?
    public var title: (() -> String)?
    
    public var height: ((UITableView, Int) -> CGFloat)?
    public var estimatedHeight: ((UITableView, Int) -> CGFloat)?
    public var customIdentifier: String?
    
    public init(reuseIdentifier: String) {
        self.reuseIdentifier = reuseIdentifier
    }
    
    public init<T: UITableViewHeaderFooterView>(_: T.Type) {
        let registration = TableRegistration(for: T.self)
        self.registration = registration
        self.reuseIdentifier = registration.reuseIdentifier
    }
}

public struct RefreshControl {
    public var tintColor: UIColor?
    public var attributedText: NSAttributedString?
    public let dragAction: RefreshControlDragClosure
    
    public init(tintColor: UIColor? = nil, attributedText: NSAttributedString? = nil, dragAction: @escaping RefreshControlDragClosure) {
        self.tintColor = tintColor
        self.attributedText = attributedText
        self.dragAction = dragAction
    }
}

extension TableSectionHeaderFooter: Hashable {
    
    public func hash(into hasher: inout Hasher) {
        if let customIdentifier = customIdentifier {
            hasher.combine(customIdentifier)
        } else {
            hasher.combine(reuseIdentifier)
        }
    }
    
    public static func == (lhs: TableSectionHeaderFooter, rhs: TableSectionHeaderFooter) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}

public struct Table {
    public let sections: [TableSection]
    public let refreshControl: RefreshControl?
    
    public init(sections: [TableSection], refreshControl: RefreshControl? = nil) {
        self.sections = sections
        self.refreshControl = refreshControl
    }
    
    public init(section: TableSection, refreshControl: RefreshControl? = nil) {
        self.sections = [section]
        self.refreshControl = refreshControl
    }
    
    public func row(at indexPath: IndexPath) -> TableRow {
        return sections[indexPath.section].rows[indexPath.item]
    }
}
