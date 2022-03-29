//
//  AnimatedTable.swift
//  RentalsCA
//
//  Created by Vladyslav Gusakov on 6/16/19.
//  Copyright © 2019 RentalsCA. All rights reserved.
//

import UIKit

public struct AnimatedTable {
    
    public let refreshControl: RefreshControl?
    
    public private(set) var sections: [AnimatedTableSection]
    
    public init(sections: [AnimatedTableSection], refreshControl: RefreshControl? = nil) {
        self.sections = sections
        self.refreshControl = refreshControl
    }
    
    public init(section: AnimatedTableSection, refreshControl: RefreshControl? = nil) {
        self.sections = [section]
        self.refreshControl = refreshControl
    }
    
    public func row(at indexPath: IndexPath) -> AnimatedTableRow {
        return sections[indexPath.section].rows[indexPath.item]
    }
    
}
