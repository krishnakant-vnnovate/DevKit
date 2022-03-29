//
//  UITableView+AnimatedTable.swift
//  RentalsCA
//
//  Created by Vladyslav Gusakov on 6/16/19.
//  Copyright © 2019 RentalsCA. All rights reserved.
//

import UIKit

private var animatedTableViewDelegateKey = "AnimatedTableViewDelegate"
private var animatedTableViewDataSourceKey = "AnimatedTableViewDataSource"
private var animatedTableViewDiffCalculatorKey = "AnimatedTableViewDiffCalculator"

extension UITableView {
    
    public func register(table: AnimatedTable) {
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
    
    public func configure(with table: AnimatedTable,
                          didScroll: ((UIScrollView) -> Void)? = nil,
                          didReloadData: (() -> Void)? = nil) {
        //Register
        register(table: table)
        
        //Diff Calculator
        let animatedTableViewDiffCalculator = AnimatedTableViewDiffCalculator(tableView: self)
        self.animatedTableViewDiffCalculator = animatedTableViewDiffCalculator
        
        //Delegate
        animatedTableViewDelegate = AnimatedTableViewDelegate(table: table)
        animatedTableViewDelegate?.didScroll = didScroll
        delegate = animatedTableViewDelegate
        
        //Data Source
        animatedTableViewDataSource = AnimatedTableViewDataSource(table: table, dataSourceProvider: animatedTableViewDiffCalculator)
        dataSource = animatedTableViewDataSource
        
        animatedTableViewDiffCalculator.configure(with: table)
        
        if let refreshControl = table.refreshControl, self.refreshControl == nil {
            self.refreshControl = UIRefreshControl()
            self.refreshControl?.tintColor = refreshControl.tintColor
            self.refreshControl?.didDrag = refreshControl.dragAction
            self.refreshControl?.attributedTitle = refreshControl.attributedText
        }
        
        reloadData {
            didReloadData?()
        }
    }
    
    public func update(with table: AnimatedTable) {
        register(table: table)
        animatedTableViewDelegate?.table = table
        animatedTableViewDataSource?.table = table
        animatedTableViewDiffCalculator?.update(with: table)
    }
    
    public func configured(with table: AnimatedTable) -> UITableView {
        configure(with: table)
        return self
    }
    
    private var animatedTableViewDataSource: AnimatedTableViewDataSource? {
        get {
            return objc_getAssociatedObject(self, &animatedTableViewDataSourceKey) as? AnimatedTableViewDataSource
        }
        
        set {
            objc_setAssociatedObject(self, &animatedTableViewDataSourceKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    private var animatedTableViewDelegate: AnimatedTableViewDelegate? {
        get {
            return objc_getAssociatedObject(self, &animatedTableViewDelegateKey) as? AnimatedTableViewDelegate
        }
        
        set {
            objc_setAssociatedObject(self, &animatedTableViewDelegateKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    private var animatedTableViewDiffCalculator: AnimatedTableViewDiffCalculator? {
        get {
            return objc_getAssociatedObject(self, &animatedTableViewDiffCalculatorKey) as? AnimatedTableViewDiffCalculator
        }
        
        set {
            objc_setAssociatedObject(self, &animatedTableViewDiffCalculatorKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

