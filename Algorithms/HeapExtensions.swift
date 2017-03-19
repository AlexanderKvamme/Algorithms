//
//  HeapExtensions.swift
//  Algorithms
//
//  Created by Alexander Kvamme on 16/03/2017.
//  Copyright © 2017 Alexander Kvamme. All rights reserved.
//

import Foundation

// struct

struct heapContent<T> {
    var index: Int
    var value: T
    var heapSize: Int
}

// protocol

protocol ChildServices{
    var hasAChild: Bool { get }
    var hasLeftChild: Bool { get }
    var hasRightChild: Bool { get }
    var hasParent: Bool { get }
}

// protocol extension

extension heapContent {
    
    // init
    
    init(_ index: Int, _ value: T, _ heapSize: Int) {
        self.index = index
        self.value = value
        self.heapSize = heapSize
    }
   
}

extension heapContent : ChildServices {
    
    // Boolean helper computed properties
    
    public var hasAChild: Bool {
        return (heapSize > 1 + index*2)
    }
    
    var hasLeftChild: Bool {
        return (heapSize > 1 + index*2 )
    }
    
    var hasRightChild: Bool {
        return heapSize > 2*index + 2
    }
    
    var hasParent: Bool {
        return index != 0
    }
    
    var parentIndex: Int {
        
        if index%2 == 1 {
            return Int(floor(Double(index/2)))
        } else {
            return Int(floor(Double((index-1)/2)))
        }
    }
    
    var getLeftChildIndex: Int {
        return index*2+1
    }
    
    var getRightChildIndex: Int {
        return index*2+2
    }
}
