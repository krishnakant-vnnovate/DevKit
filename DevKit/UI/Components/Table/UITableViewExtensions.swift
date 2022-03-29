//
//  UITableViewExtensions.swift
//  DevKit
//
//  Created by Vladyslav Gusakov on 5/5/19.
//  Copyright © 2019 Vladyslav Gusakov. All rights reserved.
//

import UIKit

// MARK: - Properties
public extension UITableView {
    
    /// Index path of last row in tableView.
    var indexPathForLastRow: IndexPath? {
        return indexPathForLastRow(inSection: lastSection)
    }
    
    /// Index of last section in tableView.
    var lastSection: Int {
        return numberOfSections > 0 ? numberOfSections - 1 : 0
    }
    
}

// MARK: - Methods
public extension UITableView {
    
    /// Number of all rows in all sections of tableView.
    ///
    /// - Returns: The count of all rows in the tableView.
    func numberOfRows() -> Int {
        var section = 0
        var rowCount = 0
        while section < numberOfSections {
            rowCount += numberOfRows(inSection: section)
            section += 1
        }
        return rowCount
    }
    
    /// IndexPath for last row in section.
    ///
    /// - Parameter section: section to get last row in.
    /// - Returns: optional last indexPath for last row in section (if applicable).
    func indexPathForLastRow(inSection section: Int) -> IndexPath? {
        guard section >= 0 else { return nil }
        guard numberOfRows(inSection: section) > 0  else {
            return IndexPath(row: 0, section: section)
        }
        return IndexPath(row: numberOfRows(inSection: section) - 1, section: section)
    }
    
    /// Reload data with a completion handler.
    ///
    /// - Parameter completion: completion handler to run after reloadData finishes.
    func reloadData(_ completion: @escaping () -> Void) {
        UIView.animate(withDuration: 0, animations: {
            self.reloadData()
        }, completion: { _ in
            completion()
        })
    }
    
    /// Remove TableFooterView.
    func removeTableFooterView() {
        tableFooterView = nil
    }
    
    /// Remove TableHeaderView.
    func removeTableHeaderView() {
        tableHeaderView = nil
    }
    
    /// Check whether IndexPath is valid within the tableView
    ///
    /// - Parameter indexPath: An IndexPath to check
    /// - Returns: Boolean value for valid or invalid IndexPath
    var isIndexPathValid: (IndexPath) -> Bool {
        return { indexPath in
            return indexPath.section < self.numberOfSections &&
                indexPath.row < self.numberOfRows(inSection: indexPath.section)
        }
    }
    
    /// Safely scroll to possibly invalid IndexPath
    ///
    /// - Parameters:
    ///   - indexPath: Target IndexPath to scroll to
    ///   - scrollPosition: Scroll position
    ///   - animated: Whether to animate or not
    func safeScrollToRow(at indexPath: IndexPath, position: UITableView.ScrollPosition, animated: Bool) {
        guard isIndexPathValid(indexPath) else { return }
        scrollToRow(at: indexPath, at: position, animated: animated)
    }
}
