//
//  GraphViewController.swift
//  GraphTraversals
//
//  Created by Josh Marasigan on 8/10/18.
//  Copyright © 2018 Josh Marasigan. All rights reserved.
//

import Foundation
import UIKit

class GraphViewController : UIViewController {
    
    var onClick: (() -> Void)? = nil
    
    var contentView = UIView()
    lazy var treeView: UIView = {
        let view = UIView()
        view.tag = 1
        
        for h in 2 ..< 4 {
            let l1 = UIView()
            l1.tag = h
            
            for i in 1 ..< 3 {
                let l2 = UIView()
                l2.tag = 4 + i
                
                for j in 1 ..< 3 {
                    let l3 = UIView()
                    l3.tag = 8 + j
                    
                    for k in 1 ..< 3 {
                        let l4 = UIView()
                        l4.tag = 16 + k
                        l3.addSubview(l4)
                    }
                    
                    l2.addSubview(l3)
                }
                
                l1.addSubview(l2)
            }
            
            view.addSubview(l1)
        }
        
        return view
    }()
    
    // MARK: - VC Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configUI()
    }
    
    // MARK: - UI
    private func configUI() {
        self.view.backgroundColor = UIColor.blue
        self.view.tag = 0
        self.contentView.tag = 1
        
        let label = UILabel(frame: CGRect(x: 0, y: 0,
                                          width: Int(UIScreen.main.bounds.width * 0.8),
                                          height: Int(UIScreen.main.bounds.height/4)))
        
        label.center = CGPoint(x: UIScreen.main.bounds.width/2,
                               y: UIScreen.main.bounds.height/2)
        
        label.textAlignment = .center
        label.text = "Traverse this view hierarchy"
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = .white
        self.view.addSubview(label)
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(onButtonClick))
        self.view.addGestureRecognizer(gesture)
        
        self.addChildViews()
    }
    
    private func addChildViews() {
        
        self.view.addSubview(self.contentView)
        
        for i in 2 ..< 25 {
            let subView = UIView()
            subView.tag = i
            self.contentView.addSubview(subView)
        }
        
        for view in self.contentView.subviews {
            for i in 1 ..< 4 {
                let grandChildView = UIView()
                grandChildView.tag = i + 25 + 100
                
                for j in 1 ... 3 {
                    let lastChild = UIView()
                    lastChild.tag = j + 3 + 25 + 1000
                    grandChildView.addSubview(lastChild)
                }
                view.addSubview(grandChildView)
            }
        }
    }
    
    @objc private func onButtonClick() {
        self.onClick?()
    }
}
