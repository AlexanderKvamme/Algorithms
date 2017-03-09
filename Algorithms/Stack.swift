//
//  Stack.swift
//  Algorithms
//
//  Created by Alexander Kvamme on 09/03/2017.
//  Copyright © 2017 Alexander Kvamme. All rights reserved.
//

import Foundation

// MARK: - Node

public class StackNode<T> {
    
    private var value: T?
    var nextNode: StackNode<T>?
    
    //init
    init(_ value: T?) {
        self.value = value
    }
    
    //getValue
    func getValue() -> T?{
        return value
    }
    
}

// MARK: - Stack

public class Stack<T> {

    var topNode: StackNode<T>?
    var queue = [StackNode<T>]()
    
    //init
    init(_ initialNode: StackNode<T>?) {
        
        if let initialNode = initialNode {
            queue.append(initialNode)
        }
        topNode = initialNode
    }
    
    var topValue: T? {
        return topNode?.getValue()
    }
    

    // funksjoner
    
    func push(_ newNode: StackNode<T>){
        queue.append(newNode)
        newNode.nextNode = topNode
        topNode = newNode
    }
    
    func pop() -> StackNode<T>? {
        topNode = topNode?.nextNode
        return queue.removeLast()
    }
}
