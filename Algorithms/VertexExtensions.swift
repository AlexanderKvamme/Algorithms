//
//  Extensions.swift
//  Algorithms
//
//  Created by Alexander Kvamme on 11/03/2017.
//  Copyright © 2017 Alexander Kvamme. All rights reserved.
//

import Foundation

extension Vertex where T: Equatable {
    // makes two verteces equatable if their generic type is equatable
    static func ==(lhs: Vertex, rhs: Vertex) -> Bool {
        return true
        // FIXME: now
    }
    static func isEqual(_ object: Any?) -> Bool {
        return true
    }
}
