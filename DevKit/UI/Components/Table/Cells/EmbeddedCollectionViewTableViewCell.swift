//
//  EmbeddedCollectionViewTableViewCell.swift
//  DevKit
//
//  Created by Vladyslav Gusakov on 5/5/19.
//  Copyright © 2019 Vladyslav Gusakov. All rights reserved.
//

import UIKit

open class EmbeddedCollectionViewTableViewCell: UITableViewCell {

    @IBOutlet public private(set) var collectionView: UICollectionView!
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isScrollEnabled = false
    }
    
    override open func systemLayoutSizeFitting(_ targetSize: CGSize,
                                          withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority,
                                          verticalFittingPriority: UILayoutPriority) -> CGSize {
        collectionView.frame = CGRect(x: 0, y: 0, width: targetSize.width, height: 1000)
        collectionView.layoutIfNeeded()
        collectionView.collectionViewLayout.invalidateLayout()
        collectionView.frame = CGRect(origin: .zero, size: collectionView.collectionViewLayout.collectionViewContentSize)
        
        return collectionView.frame.size
    }
    
    public func configure(with collection: Collection) {
        collectionView.configure(with: collection)
        contentView.layoutIfNeeded()
    }
}
