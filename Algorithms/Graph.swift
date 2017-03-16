//
//  Graph.swift
//  Algorithms
//
//  Created by Alexander Kvamme on 10/03/2017.
//  Copyright © 2017 Alexander Kvamme. All rights reserved.
//

import Foundation

// MARK: - Graph

public class SwiftGraph<T> {
    private var canvas: [Vertex<T>]
    private var isDirected: Bool
    
    init() {
        isDirected = false
        canvas = [Vertex<T>]()
    }
}

// MARK: - Vertex

public class Vertex<T> {
    typealias Verteces = [Vertex]?
    
    var key: T?
    var neibours: Verteces
    
    // Inita
    
    init(_ key: T?) {
        self.key = key
    }
    
    convenience init( _ key: T, verteces: Verteces){
        self.init(key)
        neibours = verteces
    }
}

// MARK: - Edge
public class Edge<T> {
    var weight: Int
    var from: Vertex<T>
    var to: Vertex<T>
    
    init(from: Vertex<T>, to: Vertex<T>, weight: Int){
        self.from = from
        self.to = to
        self.weight = 0
    }
}
