//
//  File.swift
//  Algorithms
//
//  Created by Alexander Kvamme on 13/03/2017.
//  Copyright © 2017 Alexander Kvamme. All rights reserved.
//

import Foundation

// uses "extensions Edge where T: Equatable" because when we are extending, T already has a type T, so we extend Edge only where this T (which is already decided when checking this) is of type Equatable

extension Edge where T: Equatable {
    static func ==(lhs: Edge, rhs: Edge) -> Bool {
        return (lhs.from.key == rhs.from.key && lhs.to.key == rhs.from.key && lhs.weight == rhs.weight)
    }
}
