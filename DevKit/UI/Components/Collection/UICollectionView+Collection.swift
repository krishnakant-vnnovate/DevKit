//
//  UICollectionView+Collection.swift
//  DevKit
//
//  Created by Vladyslav Gusakov on 5/5/19.
//  Copyright © 2019 Vladyslav Gusakov. All rights reserved.
//

import UIKit
import ObjectiveC

private var collectionViewDataSourceKey = "CollectionViewDataSource"
private var collectionViewDelegateKey = "CollectionViewDataSource"

extension UICollectionView {
    public func register(collection: Collection) {
        collection.sections.forEach { section in
            section.items.forEach { item in
                register(item.registration)
            }
            
            if let header = section.header {
                register(header.registration)
            }
        }
    }
    
    public func configure(with collection: Collection,
                          checkDataHashValue: Bool = false,
                          didScroll: ((UIScrollView, Bool) -> Void)? = nil,
                          didReloadData: (() -> Void)? = nil,
                          willBeginDragging: ((UIScrollView) -> Void)? = nil,
                          willEndDragging: ((UIScrollView, CGPoint, UnsafeMutablePointer<CGPoint>) -> Void)? = nil,
                          didEndScrolling: ((UIScrollView, Bool) -> Void)? = nil) {
        if checkDataHashValue,
            let currentDataHashValue = collectionViewDataSource?.collection.dataHashValue,
            let newDataHashValue = collection.dataHashValue,
            currentDataHashValue == newDataHashValue {
            return
        }
        
        register(collection: collection)
        
        collectionViewDataSource = CollectionViewDataSource(collection: collection)
        collectionViewDelegate = CollectionViewDelegate(collection: collection)
        collectionViewDelegate.didScroll = didScroll
        collectionViewDelegate.willBeginDragging = willBeginDragging
        collectionViewDelegate.willEndDragging = willEndDragging
        collectionViewDelegate.didEndScrolling = didEndScrolling
        delegate = collectionViewDelegate
        dataSource = collectionViewDataSource
        
        reloadData {
            didReloadData?()
        }
        
        if numberOfSections > 0 && numberOfItems(inSection: 0) > 0 {
            collection.defaultSelection.map(selectItem(at:animated:scrollPosition:))
        }
        
        if let refreshControl = collection.refreshControl, self.refreshControl == nil {
            self.refreshControl = UIRefreshControl()
            self.refreshControl?.tintColor = refreshControl.tintColor
            self.refreshControl?.attributedTitle = refreshControl.attributedText
            self.refreshControl?.didDrag = refreshControl.dragAction
        }
    }
    
    private var collectionViewDataSource: CollectionViewDataSource? {
        get {
            return objc_getAssociatedObject(self, &collectionViewDataSourceKey) as? CollectionViewDataSource
        }
        
        set {
            objc_setAssociatedObject(self, &collectionViewDataSourceKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    private var collectionViewDelegate: CollectionViewDelegate {
        get {
            return objc_getAssociatedObject(self, &collectionViewDelegateKey) as! CollectionViewDelegate
        }
        
        set {
            objc_setAssociatedObject(self, &collectionViewDelegateKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
