//
//  AnimatedTableSection.swift
//  RentalsCA
//
//  Created by Vladyslav Gusakov on 6/16/19.
//  Copyright © 2019 RentalsCA. All rights reserved.
//

import UIKit

public struct AnimatedTableSection {
    public let header: TableSectionHeaderFooter?
    public let footer: TableSectionHeaderFooter?
    public let rows: [AnimatedTableRow]
    
    public var height: ((UITableView, Int) -> CGFloat)?
    
    public init(rows: [AnimatedTableRow], header: TableSectionHeaderFooter? = nil, footer: TableSectionHeaderFooter? = nil) {
        self.header = header
        self.rows = rows
        self.footer = footer
    }
}

extension AnimatedTableSection: Equatable {
    
    public static func == (lhs: AnimatedTableSection, rhs: AnimatedTableSection) -> Bool {
        if lhs.rows.isEmpty && rhs.rows.isEmpty {
            return true
        }
        
        return Set(lhs.rows).intersection(Set(rhs.rows)).hasElements
    }
    
}
