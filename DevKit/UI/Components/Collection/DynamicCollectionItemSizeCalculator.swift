//
//  DynamicCollectionItemSizeCalculator.swift
//  DevKit
//
//  Created by Vladyslav Gusakov on 5/5/19.
//  Copyright © 2019 Vladyslav Gusakov. All rights reserved.
//

import UIKit

public class DynamicCollectionItemSizeCalculator<T: UICollectionViewCell> {
    
    private let prototypeCell: T
    
    public init(configure: (T) -> Void) {
        self.prototypeCell = .fromNib ?? T()
        configure(prototypeCell)
    }
    
    public var fullWidthSize: (UICollectionView, UICollectionViewLayout, IndexPath) -> CGSize {
        let prototypeCell = self.prototypeCell
        
        return { collectionView, layout, indexPath in
            return prototypeCell.contentView.systemLayoutSizeFitting(CGSize(width: collectionView.frame.width, height: 0),
                                                                     withHorizontalFittingPriority: .required,
                                                                     verticalFittingPriority: .fittingSizeLevel)
        }
    }
    
    public var size: (UICollectionView, UICollectionViewLayout, IndexPath) -> CGSize {
        let prototypeCell = self.prototypeCell
        
        return { collectionView, layout, indexPath in
            return prototypeCell.contentView.systemLayoutSizeFitting(.zero,
                                                                     withHorizontalFittingPriority: .fittingSizeLevel,
                                                                     verticalFittingPriority: .fittingSizeLevel)
        }
    }
    
    public func itemSize(width: CGFloat, height: CGFloat = 0) -> CGSize {
        let prototypeCell = self.prototypeCell
        return prototypeCell.contentView.systemLayoutSizeFitting(CGSize(width: width, height: height),
                                                                 withHorizontalFittingPriority: .required,
                                                                 verticalFittingPriority: .fittingSizeLevel)
    }
}

public class DynamicCollectionReusableItemSizeCalculator<T: UICollectionReusableView> {
    
    private let prototypeCell: T
    
    public init(configure: (T) -> Void) {
        self.prototypeCell = .fromNib ?? T()
        configure(prototypeCell)
    }
    
    public var size: (UICollectionView, UICollectionViewLayout, Int) -> CGSize {
        let prototypeCell = self.prototypeCell
        
        return { collectionView, layout, indexPath in
            return prototypeCell.systemLayoutSizeFitting(CGSize(width: collectionView.frame.width, height: 0),
                                                         withHorizontalFittingPriority: .required,
                                                         verticalFittingPriority: .fittingSizeLevel)
        }
    }
}
