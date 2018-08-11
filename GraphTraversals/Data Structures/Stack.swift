//
//  Stack.swift
//  GraphTraversals
//
//  Created by Josh Marasigan on 8/10/18.
//  Copyright © 2018 Josh Marasigan. All rights reserved.
//

import Foundation

struct Stack<T> {
    var array = [T]()
    
    mutating func push(_ element: T) {
        array.append(element)
    }
    
    mutating func pop() -> T? {
        if !array.isEmpty {
            // O(1)
            return array.removeLast()
        }
        return nil
    }
    
    func peek() -> T? {
        if !array.isEmpty {
            return array[array.count - 1]
        }
        return nil
    }
}
