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
    
    // MARK: - Heap tests
    
    func test_heap_subscript() {
        let heap = Heap<Int>(100)
        heap.add(3)
        heap.add(5)
        
        XCTAssert(heap[2]?.index == 2)
        XCTAssert(heap[2]?.value == 5)
    }
    
    // MARK: - Bool tests
    
    func test_nodes_hasBooleanValuesForChildren() {
        let heap = Heap<Int>(100)
        heap.add(3)
        heap.add(5)
        
        XCTAssert(heap[0]?.hasAChild == true)
        XCTAssert(heap[0]?.hasRightChild == true)
        XCTAssert(heap[0]?.hasLeftChild == true)
        
        XCTAssert(heap[1]?.hasAChild == false)
        XCTAssert(heap[1]?.hasLeftChild == false)
        XCTAssert(heap[1]?.hasRightChild == false)
        
        XCTAssert(heap[2]?.hasAChild == false)
        XCTAssert(heap[2]?.hasLeftChild == false)
        XCTAssert(heap[2]?.hasRightChild == false)
    }
    
    func test_nodes_canGetChildrenIndex() {
        let heap = Heap<Int>(10)
        heap.add(20)
        heap.add(30)
        heap.add(40)
        heap.add(50)
        heap.add(60)
        heap.add(70)
        heap.add(80)
        heap.add(90)
        
        XCTAssert(heap[0]?.getLeftChildIndex == 1)
        XCTAssert(heap[0]?.getRightChildIndex == 2)
        
        XCTAssert(heap[1]?.getLeftChildIndex == 3)
        XCTAssert(heap[1]?.getRightChildIndex == 4)
        
        XCTAssert(heap[2]?.getLeftChildIndex == 5)
        XCTAssert(heap[2]?.getRightChildIndex == 6)
        
        XCTAssert(heap[3]?.getLeftChildIndex == 7)
        XCTAssert(heap[3]?.getRightChildIndex == 8)
        
        
    }
    
    func test_nodes_hasParent() {
        let heap = Heap<Int>(100)
        heap.add(3)
        heap.add(5)
        
        XCTAssert(heap[0]?.hasParent == false)
        XCTAssert(heap[1]?.hasParent == true)
        XCTAssert(heap[2]?.hasParent == true)
    }
    
    func test_nodes_parentIndex() {
        let heap = Heap<Int>(1)
        heap.add(3)
        heap.add(5)
        heap.add(10)
        heap.add(20)
        heap.add(30)
        heap.add(40)
        
        print(heap[1]!.parentIndex)
        
        XCTAssert(heap[1]!.parentIndex == 0)
        XCTAssert(heap[2]!.parentIndex == 0)
        XCTAssert(heap[3]!.parentIndex == 1)
        XCTAssert(heap[4]!.parentIndex == 1)
        XCTAssert(heap[5]!.parentIndex == 2)
        XCTAssert(heap[6]!.parentIndex == 2)
    }
    
    // MARK: - Functions
    
    func test_swap() {
        let heap = Heap<Int>(100)
        heap.add(3)
        heap.add(5)
        
        heap.swapNodes(firstIndex: 0, with: 2)
        
        XCTAssert(heap[0]?.value == 5)
    }
    
    /*removes the lowest element out of the heap. Lowest element is on top */
    
    func test_poll() {
        let heap = Heap<Int>(5)
        heap.add(3)
        heap.add(1)
        heap.add(10)

        XCTAssert(heap.poll() == 1)
//        XCTAssert(heap.poll() == 3)
//        XCTAssert(heap.poll() == 5)
//        XCTAssert(heap.poll() == 10)

        // FIXME: - TODO
    }
    
    func test_heapifyUp() {
        /*Begynner med det siste elementet i arrayet og jobber seg opp. Sammenlikner parent og child og flytter den minste oppover*/
        
        let heap = Heap<Int>(100)
        heap.add(200)
        heap.add(10)
        
        //heap.heapifyUp()
        XCTAssert(heap[0]?.value == 10)
    }
    
    func test_heapifyDown() {
        /*Etter en poll, er det bare den siste verdien på toppen, denne er ikke nødvendigvis minst. Derfor må vi ordne i greiene, vi må heapifyen nedover*/
        
        let heap = Heap<Int>(5)
        heap.add(3)
        heap.add(1)
        heap.add(10)
        
        _ = heap.poll()
        XCTAssert(heap[0]?.value == 3)
        
        _ = heap.poll()
        XCTAssert(heap[0]?.value == 5)
        
        _ = heap.poll()
        XCTAssert(heap[0]?.value == 10)
        
        _ = heap.poll()
        XCTAssert(heap[0]?.value == nil)
    }
}

