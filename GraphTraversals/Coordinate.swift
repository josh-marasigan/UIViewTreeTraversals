//
//  Coordinate.swift
//  GraphTraversals
//
//  Created by Josh Marasigan on 8/10/18.
//  Copyright © 2018 Josh Marasigan. All rights reserved.
//

import Foundation

struct Coordinate: Hashable {
    var x: Int
    var y: Int
    
    init(x: Int, y: Int, _ parent: (x: Int, y: Int)? = nil) {
        self.x = x
        self.y = y
    }
    
    var hashValue: Int {
        return (x.hashValue ^ y.hashValue) &* 16777619
    }
    
    static func == (lhs: Coordinate, rhs: Coordinate) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y
    }
}
