//
//  Heap.swift
//  Algorithms
//
//  Created by Alexander Kvamme on 14/03/2017.
//  Copyright © 2017 Alexander Kvamme. All rights reserved.
//

import Foundation

/* Heaps are a simple form of a graph/tree but it is based on an array of values, instead of node structs/classes
 */

public class Heap<T> {
    
    private var size = Int()
    private var valueList = [T]()
    var capacity = 3
    
    // Bools
    func hasLeftChild(_ i: Int) -> Bool {
        return (self.size > 1+i*2 )
        // true hvis size er større eller lik 1 + 2
    }
    
    func hasRightChild(_ i: Int) -> Bool {
        return (self.size > 2*i + 2)
    }
    
    // init
    
    init(_ initialValue: T) {
        self.valueList.append(initialValue)
        size = 1
    }
    
    // functions
    
    func add(_ value: T){
        ensureEnoughSpace()
        valueList.append(value)
        size += 1
    }
    
    func peek() -> T? {
        return valueList.last
    }
    
    func getLeftChildIndex(_ i: Int) -> Bool {
        return (self.size >= i*2)
        
    }
    
    public func ensureEnoughSpace(){
        if size == capacity { // is full, make new row
            fatalError("ensureEnoughSpace")
        }
    }
    
    

}
