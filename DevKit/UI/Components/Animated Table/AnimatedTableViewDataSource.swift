//
//  AnimatedTableViewDataSource.swift
//  RentalsCA
//
//  Created by Vladyslav Gusakov on 6/16/19.
//  Copyright © 2019 RentalsCA. All rights reserved.
//

import UIKit
import Dwifft

public protocol TableViewDataSourceProvider: class {
    var numberOfSections: Int { get }
    func numberOfRowsInSection(_ section: Int) -> Int
}

public class AnimatedTableViewDataSource: NSObject, UITableViewDataSource {
    
    public var table: AnimatedTable
    private let dataSourceProvider: TableViewDataSourceProvider
    
    public init(table: AnimatedTable, dataSourceProvider: TableViewDataSourceProvider) {
        self.table = table
        self.dataSourceProvider = dataSourceProvider
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSourceProvider.numberOfRowsInSection(section)
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = table.row(at: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: row.reuseIdentifier, for: indexPath)
        row.configure?(tableView, cell)
        return cell
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return dataSourceProvider.numberOfSections
    }
    
    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return table.sections[safe: section]?.header?.title?()
    }
    
}
