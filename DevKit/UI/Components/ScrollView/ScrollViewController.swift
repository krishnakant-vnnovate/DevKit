//
//  ScrollViewController.swift
//  DevKit
//
//  Created by Vladyslav Gusakov on 5/5/19.
//  Copyright © 2019 Vladyslav Gusakov. All rights reserved.
//

import UIKit

open class ScrollViewController: UIViewController {
    
    //MARK: Properties
    public let scrollView = ScrollView()
    
    //MARK: Lifecycle
    override open func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    override open func loadView() {
        super.loadView()
        
        scrollView.setContentView(with: view)
        super.view = scrollView
        updateViewConstraints()
    }
    
    //MARK: Methods
    func configure() {
        view.backgroundColor = .white
        view.setNeedsUpdateConstraints()
        scrollView.delegate = self
    }
    
}

//MARK: UIScrollViewDelegate
extension ScrollViewController: UIScrollViewDelegate {
}
