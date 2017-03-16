//
//  HeapTests.swift
//  Algorithms
//
//  Created by Alexander Kvamme on 14/03/2017.
//  Copyright © 2017 Alexander Kvamme. All rights reserved.
//

import XCTest
@testable import Algorithms

class HeapTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // Heap
    
    func test_heap_isInitializable() {
        let myHeap2 = Heap<Int>(50)
        
        XCTAssert(myHeap2.capacity == 3)
    }
    
    // children
    
    // Nodes
    
    func test_nodes_addableNodes(){
        let numberToAdd = 4
        
        let heap = Heap<Int>(100)
        heap.add(numberToAdd)
        
        guard let latestValue = heap.peek() else {
            fatalError("no value to unwrap")
        }
        XCTAssert(latestValue == numberToAdd)
    }
    
    func test_nodes_canAddMultiepleValues(){
        let firstNumberToAdd = 10
        let secondNumberToAdd = 4
        
        let heap = Heap<Int>(100)
        heap.add(firstNumberToAdd)
        heap.add(secondNumberToAdd)
        
        guard let latestValue = heap.peek() else {
            fatalError("no value to unwrap")
        }
        XCTAssert(latestValue == secondNumberToAdd)
    }
    
    // Bool tests
    
    func test_nodes_hasLeftChildren(){
        let heap = Heap<Int>(100)
        heap.add(3)
        heap.add(5)
        
        XCTAssertTrue(heap.hasLeftChild(0))
        XCTAssertFalse(heap.hasLeftChild(1))
        XCTAssertFalse(heap.hasLeftChild(2))
    }
    
    func test_nodes_hasRightChildren(){
        let heap = Heap<Int>(100)
        heap.add(3)
        heap.add(5)
        
        XCTAssertTrue(heap.hasRightChild(0))
        XCTAssertFalse(heap.hasRightChild(1))
        XCTAssertFalse(heap.hasRightChild(2))
    }
    
}
