//
//  UITableView+Table.swift
//  DevKit
//
//  Created by Vladyslav Gusakov on 5/5/19.
//  Copyright © 2019 Vladyslav Gusakov. All rights reserved.
//

import UIKit

private var tableViewDataSourceKey = "TableViewDataSource"
private var tableViewDelegateKey = "TableViewDelegateSource"

extension UITableView {
    
    public func register(table: Table) {
        table.sections.forEach { section in
            section.rows.forEach { item in
                item.registration.map(register)
            }
            
            if let header = section.header {
                header.registration.map(register)
            }
            
            if let footer = section.footer {
                footer.registration.map(register)
            }
        }
    }
    
    public func configure(with table: Table,
                          didScroll: ((UIScrollView) -> Void)? = nil,
                          didReloadData: (() -> Void)? = nil,
                          willDrag: ((UIScrollView) -> Void)? = nil,
                          didEndDecelerating: ((UIScrollView) -> Void)? = nil,
                          shouldAnimateReload: Bool = true) {
        register(table: table)
        
        tableViewDataSource = TableViewDataSource(table: table)
        tableViewDelegate = TableViewDelegate(table: table)
        tableViewDelegate.didScroll = didScroll
        tableViewDelegate.willDrag = willDrag
        tableViewDelegate.didEndDecelerating = didEndDecelerating
        
        dataSource = tableViewDataSource
        delegate = tableViewDelegate
        
        if let refreshControl = table.refreshControl, self.refreshControl == nil {
            self.refreshControl = UIRefreshControl()
            self.refreshControl?.tintColor = refreshControl.tintColor
            self.refreshControl?.didDrag = refreshControl.dragAction
        }
        
        if shouldAnimateReload {
            reloadData {
                didReloadData?()
            }
            return
        }
        
        //Currently does not handle didReloadData()
        self.reloadData()
        
    }
    
    public func configured(with table: Table) -> UITableView {
        configure(with: table)
        return self
    }
    
    private var tableViewDataSource: TableViewDataSource {
        get {
            return objc_getAssociatedObject(self, &tableViewDataSourceKey) as! TableViewDataSource
        }
        
        set {
            objc_setAssociatedObject(self, &tableViewDataSourceKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    private var tableViewDelegate: TableViewDelegate {
        get {
            return objc_getAssociatedObject(self, &tableViewDelegateKey) as! TableViewDelegate
        }
        
        set {
            objc_setAssociatedObject(self, &tableViewDelegateKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
