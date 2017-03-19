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


public class Heap<T: Comparable> {
    
    private var size = Int()
    private var items = [T]()
    //public var capacity = 3
    
    subscript(i: Int) -> heapContent<T>? {
        
        // sender her inn i 2, som er mindre enn (3-1) = 2,
        if i < size {
            
            print("heapContent:")
            print("i: ", i)
            print("valueList[i]", items[i])
            print("size: ", size)
            return heapContent(i, items[i], size)
        } else {
            // if tryna access element thats not defined
            return nil
        }
    }
    
    // init
    
    init(_ initialValue: T) {
        self.items.append(initialValue)
        size = 1
    }
    
    // functions
    
    public func poll() -> T? {
        if items.count == 0 {
            return nil
        }
        let itemToReturn = items[0]
        if items.count > 1 {
            items[0] = items.removeLast()
        } else {
            //dont update first item
        }
        size -= 1
        heapifyDown()
        return itemToReturn
    }
    
    func add(_ value: T){
        items.append(value)
        size += 1
        heapifyUp()
    }
    
    func swapNodes(firstIndex: Int, with secondIndex: Int) {
        let tempValue = items[firstIndex]
        
        items[firstIndex] = items[secondIndex]
        items[secondIndex] = tempValue
    }
    
    private func heapifyUp() {
        
        var index: Int = size-1

        // subscript returnerer en heapContent<T>...

        while let item = self[index] {
            if index == 0 { return }
            
            if item.hasParent {
                if item.value < items[item.parentIndex] {
                    print("swapping")
                    swapNodes(firstIndex: index, with: item.parentIndex)
                }
                index = item.parentIndex
            }
        }
    }

    
    private func heapifyDown() {
        
        // kall på denne etter poll
        guard items.count > 1 else { return }
        
        // bigger than 1, har child, sammenlikne
        
        var index = 0
        
        var lowestChildIndex = Int()
        
        while self[index]!.hasLeftChild{
            if self[index]!.hasRightChild {
                let rightChildIndex = self[index]!.getRightChildIndex
                let leftChildIndex = self[index]!.getLeftChildIndex
                if self[rightChildIndex]!.value < self[leftChildIndex]!.value {
                    lowestChildIndex = rightChildIndex
                } else {
                    lowestChildIndex = leftChildIndex
                }
                if self[index]!.value > self[lowestChildIndex]!.value {
                swapNodes(firstIndex: index, with: lowestChildIndex)
                }
                index = lowestChildIndex
            } else {
                // har kun left
                let leftChildIndex = self[index]!.getLeftChildIndex
                if self[index]!.value > self[leftChildIndex]!.value {
                    swapNodes(firstIndex: index, with: leftChildIndex)
                }
                index = leftChildIndex
            }
        }
    }
    
    func peek() -> T? {
        return items.last
    }
    

//    func getLeftChildIndex(_ i: Int) -> Int {
//        return i*2+1
//    }
//    
//    func getRightChildIndex(_ i: Int) -> Int {
//        return i*2+2
//    }
    
}

