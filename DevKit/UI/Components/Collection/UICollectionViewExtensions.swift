//
//  UICollectionViewExtensions.swift
//  DevKit
//
//  Created by Vladyslav Gusakov on 5/5/19.
//  Copyright © 2019 Vladyslav Gusakov. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    /// Index path of last item in collectionView.
    public var indexPathForLastItem: IndexPath? {
        return indexPathForLastItem(inSection: lastSection)
    }
    
    /// SwifterSwift: Index of last section in collectionView.
    public var lastSection: Int {
        return numberOfSections > 0 ? numberOfSections - 1 : 0
    }
    
    public func safeScrollToItem(at indexPath: IndexPath, position: UICollectionView.ScrollPosition, animated: Bool) {
        guard isIndexPathValid(indexPath) else { return }
        scrollToItem(at: indexPath, at: position, animated: animated)
    }
    
    public var isIndexPathValid: (IndexPath) -> Bool {
        return { indexPath in
            return indexPath.section < self.numberOfSections &&
                indexPath.item < self.numberOfItems(inSection: indexPath.section)
        }
    }
    
    /// Number of all items in all sections of collectionView.
    ///
    /// - Returns: The count of all rows in the collectionView.
    public func numberOfItems() -> Int {
        var section = 0
        var itemsCount = 0
        while section < self.numberOfSections {
            itemsCount += numberOfItems(inSection: section)
            section += 1
        }
        return itemsCount
    }
    
    /// IndexPath for last item in section.
    ///
    /// - Parameter section: section to get last item in.
    /// - Returns: optional last indexPath for last item in section (if applicable).
    public func indexPathForLastItem(inSection section: Int) -> IndexPath? {
        guard section >= 0 else {
            return nil
        }
        guard section < numberOfSections else {
            return nil
        }
        guard numberOfItems(inSection: section) > 0 else {
            return IndexPath(item: 0, section: section)
        }
        return IndexPath(item: numberOfItems(inSection: section) - 1, section: section)
    }
    
    /// Reload data with a completion handler.
    ///
    /// - Parameter completion: completion handler to run after reloadData finishes.
    public func reloadData(_ completion: @escaping () -> Void) {
        UIView.animate(withDuration: 0, animations: {
            self.reloadData()
        }, completion: { _ in
            completion()
        })
    }
    
}

