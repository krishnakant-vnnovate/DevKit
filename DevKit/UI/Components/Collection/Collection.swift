//
//  Collection.swift
//  DevKit
//
//  Created by Vladyslav Gusakov on 5/5/19.
//  Copyright © 2019 Vladyslav Gusakov. All rights reserved.
//

import UIKit

protocol CollectionItemInterface {
    var configure: ((UICollectionViewCell) -> Void)? { get set }
    var didSelect: ((UICollectionView, IndexPath) -> Void)? { get set }
    var didCenter: (() -> Void)? { get set }
    var willDisplay: ((UICollectionView, UICollectionViewCell, IndexPath) -> Void)? { get set }
    var didDisplay: ((UICollectionView, UICollectionViewCell, IndexPath) -> Void)? { get set }
    var size: ((UICollectionView, UICollectionViewLayout, IndexPath) -> CGSize)? { get set }
    
    init<T: UICollectionViewCell>(_ type: T.Type)
}

public struct Item: CollectionItemInterface {
    
    let registration: Registration
    
    public internal(set) var configure: ((UICollectionViewCell) -> Void)?
    public internal(set) var didSelect: ((UICollectionView, IndexPath) -> Void)?
    public internal(set) var willDisplay: ((UICollectionView, UICollectionViewCell, IndexPath) -> Void)?
    public internal(set) var didDisplay: ((UICollectionView, UICollectionViewCell, IndexPath) -> Void)?
    
    public internal(set) var didCenter: (() -> Void)?
    public internal(set) var size: ((UICollectionView, UICollectionViewLayout, IndexPath) -> CGSize)?
    
    init<T: UICollectionViewCell>(_: T.Type) {
        self.registration = Registration(for: T.self)
    }
}

public struct Section {
    
    public let header: SectionHeader?
    public let items: [Item]
    
    public var inset: ((UICollectionView, UICollectionViewLayout, Int) -> UIEdgeInsets)?
    public var minimumLineSpacing: ((UICollectionView, UICollectionViewLayout, Int) -> CGFloat)?
    public var minimumInteritemSpacing: ((UICollectionView, UICollectionViewLayout, Int) -> CGFloat)?
    
    public init(header: SectionHeader? = nil, items: [Item]) {
        self.header = header
        self.items = items
    }
}

public struct SectionHeader {
    
    public let registration: Registration
    
    public var configure: ((UICollectionReusableView) -> Void)?
    
    public var size: ((UICollectionView, UICollectionViewLayout, Int) -> CGSize)?
    
    public init<T: UICollectionReusableView>(_: T.Type) {
        self.registration = Registration(for: T.self, kind: UICollectionView.elementKindSectionHeader)
    }
}

public struct Collection {
    public typealias Selection = (indexPath: IndexPath, animated: Bool, scrollPosition: UICollectionView.ScrollPosition)
    
    public let sections: [Section]
    public var defaultSelection: Selection?
    public var dataHashValue: Int?
    public let refreshControl: RefreshControl?
    
    public init(sections: [Section] = [], refreshControl: RefreshControl? = nil) {
        self.sections = sections
        self.refreshControl = refreshControl
    }
    
    public init(section: Section, refreshControl: RefreshControl? = nil) {
        self.sections = [section]
        self.refreshControl = refreshControl
    }
    
    public func item(at indexPath: IndexPath) -> Item? {
        return sections[safe: indexPath.section]?.items[safe: indexPath.item]
    }
    
    public func section(at index: Int) -> Section? {
        guard let section = sections[safe: index] else { return nil }
        return section
    }
    
}
