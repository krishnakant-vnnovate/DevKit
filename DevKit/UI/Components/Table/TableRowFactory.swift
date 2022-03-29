//
//  TableRowFactory.swift
//  DevKit
//
//  Created by Vladyslav Gusakov on 5/5/19.
//  Copyright © 2019 Vladyslav Gusakov. All rights reserved.
//

import UIKit

public struct TableRowFactory<Cell: UITableViewCell> {
    public var configure: ((UITableView, Cell) -> Void)?
    public var didSelect: ((UITableView, IndexPath) -> Void)?
    public var willDisplay: ((UITableView, Cell, IndexPath) -> Void)?
    public var height: ((UITableView, IndexPath) -> CGFloat)?
    public var estimatedHeight: ((UITableView, IndexPath) -> CGFloat)?
    
    public init() { }
    
    public var row: TableRow {
        return buildRow()
    }
}

private extension TableRowFactory {
    
    func buildRow<T: TableRowInterface>() -> T {
        var row = T(Cell.self)
        
        row.configure = { [configure = self.configure] tableView, cell in
            guard let cell = cell as? Cell else {
                return
            }
            
            configure?(tableView, cell)
        }
        
        row.didSelect = didSelect
        row.height = height
        row.estimatedHeight = estimatedHeight
        row.willDisplay = { [willDisplay = self.willDisplay] tableView, cell, indexPath in
            guard let cell = cell as? Cell else {
                return
            }
            
            willDisplay?(tableView, cell, indexPath)
        }
        
        return row
    }
}
