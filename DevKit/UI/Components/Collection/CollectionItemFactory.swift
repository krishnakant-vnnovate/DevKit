//
//  CollectionItemFactory.swift
//  DevKit
//
//  Created by Vladyslav Gusakov on 5/5/19.
//  Copyright © 2019 Vladyslav Gusakov. All rights reserved.
//

import UIKit

public struct CollectionItemFactory<Cell: UICollectionViewCell> {
    
    public var configure: ((Cell) -> Void)?
    public var didSelect: ((UICollectionView, IndexPath) -> Void)?
    public var didCenter: (() -> Void)?
    public var willDisplay: ((UICollectionView, Cell, IndexPath) -> Void)?
    public var didDisplay: ((UICollectionView, Cell, IndexPath) -> Void)?
    public var size: ((UICollectionView, UICollectionViewLayout, IndexPath) -> CGSize)?
    
    public init() { }
    
    public var item: Item {
        return buildItem()
    }
    
}

private extension CollectionItemFactory {
    
    func buildItem<T: CollectionItemInterface>() -> T {
        var item = T(Cell.self)
        
        item.configure = { [configure = self.configure] cell in
            guard let cell = cell as? Cell else {
                return
            }
            
            configure?(cell)
        }
        
        item.didSelect = didSelect
        item.didCenter = didCenter
        
        item.willDisplay = { [willDisplay = self.willDisplay] collectionView, cell, indexPath in
            guard let cell = cell as? Cell else {
                return
            }
            
            willDisplay?(collectionView, cell, indexPath)
        }
        
        item.didDisplay = { [didDisplay = self.didDisplay] collectionView, cell, indexPath in
            guard let cell = cell as? Cell else {
                return
            }
            
            didDisplay?(collectionView, cell, indexPath)
        }
        
        item.size = size
        
        return item
    }
}
