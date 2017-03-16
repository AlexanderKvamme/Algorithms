//
//  GraphTests.swift
//  Algorithms
//
//  Created by Alexander Kvamme on 10/03/2017.
//  Copyright © 2017 Alexander Kvamme. All rights reserved.
//

import XCTest
@testable import Algorithms

class GraphTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // MARK: - Test
    
    func test_Graph_isInitializable(){
        let graph = SwiftGraph<String>()
        XCTAssertNotNil(graph)
    }
    
    func test_Vertex_isInitializable(){
        let myVertex = Vertex("value", verteces: nil)
        XCTAssertEqual(myVertex.key, "value")
    }
    
    func test_Edge_isInitializable(){
        let myVertex1 = Vertex("value 1", verteces: nil)
        let myVertex2 = Vertex("value 2", verteces: nil)
        let myEdge = Edge<String>(from: myVertex1, to: myVertex2, weight: 0)
        
        // same edge back and fourth
        XCTAssertEqual(myEdge.from.key , myVertex1.key)
        XCTAssertEqual(myEdge.to.key, myVertex2.key)
    }
    
    func test_Vertex_isEquatable(){
        let myVertex1 = Vertex("value 1", verteces: nil)
        let myVertex2 = Vertex("value 1", verteces: nil)
       
        XCTAssert(myVertex1 ==  myVertex2)
        //XCTAssertEqual(myVertex1, myVertex2) // this uses isEqual, not ==
    }
    
    func test_Edge_isEquatable(){
    
        let myVertex1 = Vertex("value 1", verteces: nil)
        let myVertex2 = Vertex("value 1", verteces: nil)
        let myVertex3 = Vertex("value 3", verteces: nil)
        
        let myEdge1 = Edge<String>(from: myVertex1, to: myVertex2, weight: 0)
        let myEdge2 = Edge<String>(from: myVertex2, to: myVertex3, weight: 0)
        
        XCTAssert(myEdge1 == myEdge2)
        XCTAssert(myEdge1 !== myEdge2)
    }
}
    
