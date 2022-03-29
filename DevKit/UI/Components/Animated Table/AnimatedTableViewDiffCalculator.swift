//
//  AnimatedTableViewDiffCalculator.swift
//  RentalsCA
//
//  Created by Vladyslav Gusakov on 6/16/19.
//  Copyright © 2019 RentalsCA. All rights reserved.
//

import UIKit
import Dwifft

class AnimatedTableViewDiffCalculator {
    
    private weak var tableView: UITableView?
    
    private var tableViewDiffCalculator: TableViewDiffCalculator<AnimatedTableSection, AnimatedTableRow>?
    
    init(tableView: UITableView) {
        self.tableView = tableView
    }
    
    func configure(with table: AnimatedTable) {
        tableViewDiffCalculator = .init(tableView: tableView, initialSectionedValues: .init(table.sectionsAndValues))
        configureDiffCalculator()
    }
    
    func update(with table: AnimatedTable) {
        tableViewDiffCalculator?.sectionedValues = .init(table.sectionsAndValues)
    }
    
    private func configureDiffCalculator() {
        tableViewDiffCalculator?.insertionAnimation = .fade
        tableViewDiffCalculator?.deletionAnimation = .fade
    }
    
}

extension AnimatedTableViewDiffCalculator: TableViewDataSourceProvider {
    public var numberOfSections: Int {
        return tableViewDiffCalculator?.numberOfSections() ?? 0
    }
    
    public func numberOfRowsInSection(_ section: Int) -> Int {
        return tableViewDiffCalculator?.numberOfObjects(inSection: section) ?? 0
    }
    
}

extension AnimatedTable {
    var sectionsAndValues: [(AnimatedTableSection, [AnimatedTableRow])] {
        return sections.map { ($0, $0.rows) }
    }
}
