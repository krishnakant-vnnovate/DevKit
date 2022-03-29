//
//  UIView+NibLoadable.swift
//  DevKit
//
//  Created by Vladyslav Gusakov on 5/5/19.
//  Copyright © 2019 Vladyslav Gusakov. All rights reserved.
//

import UIKit
import SnapKit

public protocol NibLoadable: class {
    static var nib: UINib { get }
}

extension NibLoadable {

    public static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: Bundle(for: self))
    }
}

extension NibLoadable where Self: UIView {
    
    func loadNibContent() {
        for case let view as UIView in type(of: self).nib.instantiate(withOwner: self, options: nil) {
            addSubview(view)
            view.backgroundColor = .clear
            view.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        }
    }
}

public extension NibLoadable {

    static var fromNib: Self! {
        let bundle = Bundle(for: Self.self)
        let nibName = String(describing: Self.self)
        let nibExists = bundle.path(forResource: nibName, ofType: "nib") != nil
        let nib = nibExists ? bundle.loadNibNamed(nibName, owner: nil, options: nil) : nil
        let view = nib?.first as? Self

        return view
    }
}

extension UICollectionReusableView: NibLoadable {

}
