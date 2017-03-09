//
//  StackTests.swift
//  Algorithms
//
//  Created by Alexander Kvamme on 09/03/2017.
//  Copyright © 2017 Alexander Kvamme. All rights reserved.
//

import XCTest
@testable import Algorithms

// class

class StackTests: XCTestCase {
    
    var myStack: Stack<String>!
    
    // setUp
    
    override func setUp() {
        super.setUp()
        
        let myFirstNode = StackNode<String>("first node")
        myStack = Stack<String>(nil)
    }
    
    override func tearDown() {
        super.tearDown()
    }

    // QueueNodeTests
    
    func test_queueNode_isInitializable(){
        let myNode = StackNode<String>("bam")
        XCTAssertEqual("bam", myNode.getValue())
    }
    
    // stackTests
    
    func test_stack_isInitializableWithNil(){
        XCTAssertNil(myStack.topNode)
    }
    
    func test_stack_isInitializableWithNode(){
        let textNode = StackNode<String>("text node")
        let myStack = Stack<String>(textNode)
        XCTAssertEqual(myStack.topNode?.getValue(), "text node")
    }
    
    func test_stack_isEnqueueable(){
        let mySecondNode = StackNode<String>("second node")
        myStack.push(mySecondNode)
        XCTAssertEqual(myStack.topValue, mySecondNode.getValue())
        
        let myThirdNode = StackNode<String>("third node")
        myStack.push(myThirdNode)
        XCTAssertEqual(myStack.topValue, myThirdNode.getValue())
    }
    
    func test_stack_pop(){
        let mySecondNode = StackNode<String>("second bam")
        let myThirdNode = StackNode<String>("third bam")
        
        myStack.push(mySecondNode)
        myStack.push(myThirdNode)
        
        XCTAssertEqual(myThirdNode.getValue(), myStack.topNode?.getValue())
        
        myStack.pop()
        XCTAssertEqual(myStack.topNode?.getValue(), mySecondNode.getValue())
        
    }
    
    
}
