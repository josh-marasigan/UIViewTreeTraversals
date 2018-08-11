//
//  ViewController.swift
//  GraphTraversals
//
//  Created by Josh Marasigan on 8/10/18.
//  Copyright © 2018 Josh Marasigan. All rights reserved.
//

import UIKit

// TO-DO: Views w/ multiple subviews!

class ViewController: UIViewController {

    private lazy var graphVC: GraphViewController = {
        return GraphViewController()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.graphVC.onClick = { [weak self] in
            self?.onTapFindAncestor()
//            self?.onTapDFS()
        }
        
        self.present(graphVC, animated: true, completion: nil)
    }
    
    private func onTapDFS() {
        let rootView = self.graphVC.contentView
        
        print("Pre-Order")
        self.dfsPreOrderUtilBinaryTree(rootView)
        print("")
        
        print("In-Order")
        self.dfsInOrderUtilBinaryTree(rootView)
        print("")

        print("Post-Order")
        self.dfsPostOrderUtilBinaryTree(rootView)
        print("")
    }
    
}

// Common Ancestor for UIViews
extension ViewController {
    private func onTapFindAncestor() {
        let rootView = self.graphVC.treeView
        if let first = rootView.subviews.last?.subviews.first?.subviews.last,
            let second = rootView.subviews.last?.subviews.first?.subviews.first {
            
//            if let commonAncestor = self.findFirstCommonAncestors(first, UIView()) {
            if let commonAncestor = self.findFirstCommonAncestors(first, second) {
                print("Common ancestor found w/ tag = \(commonAncestor.tag)")
            } else {
                print("Common ancestor not found")
            }
        }
    }
    
    private func findFirstCommonAncestors(_ first: UIView, _ second: UIView) -> UIView? {
        guard first.subviews.count > 0, second.subviews.count > 0 else {
            return nil
        }
        
        print(first.debugDescription)
        print(second.debugDescription)
        
        // O(h), h being the height of the view tree
        var firstViewAncestry = [UIView]()
        self.recursiveGetViewHierarchy(first, &firstViewAncestry)
        
        // O(h), h being the height of the view tree
        var secondViewAncestry = [UIView]()
        self.recursiveGetViewHierarchy(second, &secondViewAncestry)
        
        // O(h), h being the height of the view tree
        let commonAncestor: UIView? = self.findLowestCommonAncestor(firstViewAncestry, secondViewAncestry)
        
        return commonAncestor
    }
    
    // TO-DO: DEBUG
    private func findLowestCommonAncestor(_ first: [UIView], _ second: [UIView]) -> UIView? {
        
        var firstTailIndex = first.count - 1
        var secondTailIndex = second.count - 1
        
        var commonAncestor: UIView? = nil
        
        while firstTailIndex >= 0 && secondTailIndex >= 0 {
            if first[firstTailIndex] != second[secondTailIndex] {
                
                // Found parent
                if firstTailIndex + 1 < first.count,
                    secondTailIndex + 1 < second.count,
                    first[firstTailIndex + 1].tag == second[secondTailIndex + 1].tag {
                    commonAncestor = first[firstTailIndex + 1]
                }
                
                break
            }
            
            firstTailIndex -= 1
            secondTailIndex -= 1
        }
        
        if firstTailIndex == secondTailIndex, firstTailIndex == -1 {
            commonAncestor = first[0]
        }
        
        return commonAncestor
    }
    
    private func recursiveGetViewHierarchy(_ view: UIView?, _ superViews: inout [UIView]) {
        guard let view = view else { return }
        
        superViews.append(view)
        self.recursiveGetViewHierarchy(view.superview, &superViews)
    }
}

// Tree Traversals for UIViews
extension ViewController {
    // Pre-Order
    private func dfsPreOrderUtilBinaryTree(_ view: UIView?) {
        guard let view = view else { return }
        
        print(view.tag)
        self.dfsPreOrderUtilBinaryTree(view.subviews.first)
        self.dfsPreOrderUtilBinaryTree(view.subviews.last)
    }
    
    // In Order
    private func dfsInOrderUtilBinaryTree(_ view: UIView?) {
        guard let view = view else { return }
        
        self.dfsInOrderUtilBinaryTree(view.subviews.first)
        print(view.tag)
        self.dfsInOrderUtilBinaryTree(view.subviews.last)
    }
    
    // Post Order
    private func dfsPostOrderUtilBinaryTree(_ view: UIView?) {
        guard let view = view else { return }
        
        self.dfsPostOrderUtilBinaryTree(view.subviews.first)
        self.dfsPostOrderUtilBinaryTree(view.subviews.last)
        print(view.tag)
    }
}
