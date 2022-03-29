//
//  AnimatedTableViewDelegate.swift
//  RentalsCA
//
//  Created by Vladyslav Gusakov on 6/16/19.
//  Copyright © 2019 RentalsCA. All rights reserved.
//

import UIKit

public class AnimatedTableViewDelegate: NSObject, UITableViewDelegate {
    
    public var table: AnimatedTable
    public var didScroll: ((UIScrollView) -> Void)?
    
    public init(table: AnimatedTable) {
        self.table = table
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return table.row(at: indexPath).height?(tableView, indexPath) ?? tableView.rowHeight
    }
    
    public func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return table.row(at: indexPath).estimatedHeight?(tableView, indexPath) ?? tableView.estimatedRowHeight
    }
    
    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        table.row(at: indexPath).willDisplay?(tableView, cell, indexPath)
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        table.row(at: indexPath).didSelect?(tableView, indexPath)
    }
    
    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        guard let footer = table.sections[safe: section],
            let footerHeight = footer.footer?.height?(tableView, section) else {
                return .leastNonzeroMagnitude
        }
        return footerHeight
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard let header = table.sections[safe: section],
            let headerHeight = header.header?.height?(tableView, section) else {
                return .leastNonzeroMagnitude
        }
        return headerHeight
    }
    
    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let section = table.sections[safe: section],
            let footer = section.footer,
            let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: footer.reuseIdentifier) else {
                return nil
        }
        footer.configure?(view)
        return view
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let section = table.sections[safe: section],
            let header = section.header,
            let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: header.reuseIdentifier) else {
                return nil
        }
        header.configure?(view)
        return view
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        didScroll?(scrollView)
    }
    
}
