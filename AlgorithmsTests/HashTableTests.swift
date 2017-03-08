
//
//  HashTableTests.swift
//  Algorithms
//
//  Created by Alexander Kvamme on 06/03/2017.
//  Copyright © 2017 Alexander Kvamme. All rights reserved.
//

import XCTest
@testable import Algorithms

// globale variabler

private let capacity: Int = 5

class HashTableTests: XCTestCase {
    
    var hashTable = HashTable<String,String>(capacity: capacity)
    
//    override func setUp() {
//        super.setUp()
//    }
//    
//    override func tearDown() {
//        super.tearDown()
//    }
    

    func test_hashTableInit_ShouldMakeTable(){
        XCTAssertEqual(hashTable.count, 0)
    }
    
    func test_hashTable_isFillable(){
        hashTable["Erik"] = "ripped"
        XCTAssertEqual(hashTable["Erik"], "ripped")
    }
    
    func test_hashTable_isNillable(){
        hashTable["Erik"] = "something"
        hashTable["Erik"] = nil
        XCTAssertNil(hashTable["Erik"])
    }
    
    func test_takesMultipleValues(){
        
        hashTable["Tony"] = "Montana"
        hashTable["Kim"] = "Madman"
        
//        hashTable["Richard"] = "Travelman"
//        hashTable["Erik"] = "Something"
//        hashTable["KZ"] = "Skrallemester"
//        hashTable["The Kid"] = "Luremesteren"
        

        XCTAssertEqual(hashTable["Erik"], "Brok")
        XCTAssertEqual(hashTable["Kim"], "Madman")
        
        // kim returnerer Montana
        
//        XCTAssertEqual(hashTable["Richard"], "Travelman")
//        XCTAssertEqual(hashTable["Tony"], "Montana")
//        XCTAssertEqual(hashTable["KZ"], "Skrallemester")
//        XCTAssertEqual(hashTable["The Kid"], "Luremesteren")
    }
}
