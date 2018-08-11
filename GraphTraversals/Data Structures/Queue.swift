//
//  Queue.swift
//  GraphTraversals
//
//  Created by Josh Marasigan on 8/10/18.
//  Copyright © 2018 Josh Marasigan. All rights reserved.
//

import Foundation

struct Queue<T> {
    var list = [T]()
    
    mutating func enqueue(_ element: T) {
        list.append(element)
    }
    
    mutating func dequeue() -> T? {
        if !list.isEmpty {
            // O(N)
            return list.removeFirst()
        }
        return nil
    }
    
    func peek() -> T? {
        if !list.isEmpty {
            return list[0]
        } else {
            return nil
        }
    }
    
    var isEmpty: Bool {
        return list.isEmpty
    }
}
