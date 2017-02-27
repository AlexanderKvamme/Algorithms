//
//  ViewController.swift
//  Algorithms
//
//  Created by Alexander Kvamme on 27/02/2017.
//  Copyright © 2017 Alexander Kvamme. All rights reserved.
//

import UIKit





import Foundation

// first i make a node and then add all functionality needed to make a functional AVL tree

class Node{
    
    var key: Int
    var leftChildren = 0 {
        didSet{
            print("leftChildren of \(key) DIDSET: BalanceFactor now: ", balanceFactor)
            
            if abs(balanceFactor) >= 2{
                print("\(key) failed test, sending to pivot\n")
                pivot(self)
            }
        }
    }
    var rightChildren = 0 {
        didSet {
            print("rightChildren of \(key) DIDSET: BalanceFactor now: ", balanceFactor)
            
            if abs(balanceFactor) >= 2 {
                print("\(key) failed test, sending to pivot\n")
                pivot(self)
            }
        }
    }
    
    var parent: Node?
    var leftChild: Node?
    var rightChild: Node?
    
    init(_ input: Int){
        self.key = input
    }
    
    //convenience init
    
    convenience init(_ values: [Int]) {
        
        self.init(values.first!)
        
        for value in values.dropFirst(){
            self.add(value)
        }
    }
    
    // logic values
    
    var isLeftChild: Bool {
        return parent?.leftChild === self
    }
    
    var isRightChild: Bool {
        return parent?.rightChild === self
    }
    
    var hasBothChildren: Bool {
        return leftChild != nil && rightChild != nil
    }
    var hasLeftChild: Bool {
        return leftChild != nil
    }
    var hasNoLeftChild: Bool {
        return leftChild == nil
    }
    var hasRightChild: Bool {
        return rightChild != nil
    }
    var hasNoRightChild: Bool {
        return rightChild == nil
    }
    var hasNoChildren: Bool {
        return hasNoLeftChild && hasNoRightChild
    }
    var hasOnlyLeftChild: Bool {
        return hasLeftChild && hasNoRightChild
    }
    var hasOnlyRightChild: Bool {
        return hasNoLeftChild && hasRightChild
    }
    var hasOnlyOneChild: Bool {
        if (leftChild != nil && rightChild == nil) {
            return true
        }
        if (leftChild == nil && rightChild != nil) {
            return true
        }
        return false
    }
    var isLeafNode: Bool {
        return hasNoLeftChild && hasNoRightChild
    }
    var hasParent: Bool {
        return parent != nil
    }
    
    // add function
    func add(_ number: Int){
        
        /*
         if self has parent, update self until its the top node, and then add
         */
        
        
        if (key >= number && hasNoLeftChild){
            print("adding ", number)
            leftChild = Node(number)
            leftChild?.parent = self
            leftChild?.updateParents(+1)
        }
        else if ( key >= number && hasLeftChild){
            leftChild?.add(number)
            
        }
        else if (key <= number && hasRightChild) {
            rightChild?.add(number)
        }
        else if (key <= number && hasNoRightChild) {
            print("adding ", number)
            rightChild = Node(number)
            rightChild?.parent = self
            rightChild?.updateParents(+1)
        }
    }
    
    func insert(_ value: Int){
        // go to root
        // call add on it
        var node = self
        
        while case let parent? = node.parent{
            node = parent
        }
        print("i think root of tree is: ", node.key)
        node.add(value)
    }
}

// print

// print funksjonalitet
extension Node: CustomStringConvertible{
    var description: String {
        
        var s = ""
        
        if let left = self.leftChild {
            s += "(\(left.description)) <-"
        }
        s += " \(self.key) "
        
        if let right = self.rightChild {
            s += "-> (\(right.description))"
        }
        return s
    }
}

extension Node {
    func printInfo(){
        print()
        print("--PRINTING INFO--")
        print("key: ", key)
        print("parent:", parent)
        print("leftChild:", leftChild)
        print("leftChildCount:" ,leftChildren)
        print("rightChild:", rightChild)
        print("rightChildCount:" ,rightChildren)
        print("--PRINTED INFO--")
        print()
    }
}

extension Node {
    func printEntireTree(){
        print("PRINTING ENTIRE TREE")
        var node = self
        
        while case let parent? = node.parent{
            node = parent
        }
        print("top node found to start print off: ", node.key)
        print(node)
    }
}


// Time to make this into an AVL Tree

// Step 1: Balance factor

// needed to see if branches are in balance or too big difference

// to do this we need a way to calculate the depth of the branches

// count

extension Node {
    
    // update parents
    func updateParents(_ childAdjustment : Int){
        if hasParent {
            if isLeftChild{
                parent?.leftChildren += childAdjustment
            }
            if isRightChild{
                parent?.rightChildren += childAdjustment
            }
            
            // update next parent
            
            parent?.updateParents(childAdjustment)
        }
    }
}

extension Node {
    var balanceFactor: Int {
        return rightChildren - leftChildren
    }
}

// pivot functions

extension Node {
    func pivot(_ root: Node) {
        
        print("\n - now in pivot - ")
        root.printEntireTree()
        
        let rotationType = getRotationType(root)
        print("decided rotationtype: ", rotationType)
        
        switch rotationType{
        case .LL:
           rotateLL(root)
        case .LR:
            print("LR")
            rotateLR(root)
            
        case .RR:
            rotateRR(root)
        case .RL:
            print("RL")
            rotateRL(root)
            
        }
        print("pivoting LL done")
        print()
        
    }
}

// AVL rotation functions

extension Node {
    func rotateLL(_ root: Node) {
        // root er 1'eren
        // newRoot er -2'eren
        root.printInfo()
        
        let newRoot = root.leftChild!
        
        if root.hasParent {
            newRoot.parent = root.parent
            newRoot.parent?.leftChild = newRoot
        } else {
            newRoot.parent = nil
        }
        
        newRoot.rightChild = root
        newRoot.rightChildren = 1
        
        //root.rightChildren = 0
        root.leftChild = nil
        root.leftChildren = 0
        root.parent = newRoot
    }
    
    func rotateLR(_ root: Node){
        let pivotPoint = root.leftChild!
        let nodeToSwap = pivotPoint.rightChild!
        
        pivotPoint.disconnect()
        nodeToSwap.disconnect()
        
        root.leftChild = nodeToSwap
        
        nodeToSwap.parent = root
        nodeToSwap.leftChild = pivotPoint
        pivotPoint.parent = nodeToSwap
        
        pivotPoint.rightChildren = 0
        nodeToSwap.leftChildren = 1
        
        rotateLL(root)
        printEntireTree()
        
    }
    
    func rotateRR(_ root: Node){
        print("rotateRR started")
        let newRoot = root.rightChild!
        
        if root.hasParent{
            newRoot.parent = root.parent
            newRoot.parent?.rightChild = newRoot
        } else {
            newRoot.parent = nil
        }
        root.parent = newRoot
        newRoot.leftChild = root
        newRoot.leftChildren = 1
        root.rightChild = nil
        root.rightChildren = 0
        print("rotateRR ended")
    }
    
    func rotateRL(_ root: Node){
        
        let pivotPoint = root.rightChild!
        let nodeToSwap = pivotPoint.rightChild!
        
        pivotPoint.disconnect()
        nodeToSwap.disconnect()
        
        root.rightChild = nodeToSwap
        nodeToSwap.parent = root
        nodeToSwap.rightChildren = 1
        
        pivotPoint.parent = nodeToSwap
        pivotPoint.leftChildren = 0
        
        rotateRR(root)
    }
}

// connect child to parent

func connectChild(_ child: Node, toParent: Node?){
    if let parent = toParent{
        
        if child.key >= parent.key {
            parent.rightChild = child
            
        } else {
            parent.leftChild = child
        }
        child.parent = parent
    }
    else {
        child.parent = nil
    }
}

// Rotations

enum RotationType{
    case LL
    case LR
    case RR
    case RL
}

func getRotationType(_ node: Node) -> RotationType{
    if let leftChild = node.leftChild {
        if leftChild.hasLeftChild {
            return .LL
        }
        else {
            return .LR
        }
    }
    else {
        if let rightChild = node.rightChild{
            if rightChild.hasRightChild {
                return .RR
            }
        }
        return .RL
    }
}
extension Node {
    func disconnect() {
        parent = nil
        if hasLeftChild {leftChild = nil}
        if hasRightChild {rightChild = nil}
        print("\(key) disconnected from all parts")
    }
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var testTree = Node(20)
        testTree.insert(30)
        testTree.insert(40)
        testTree.printEntireTree()
        testTree.insert(50)
        testTree.insert(60)
        testTree.printEntireTree()

        
        print("root key now: ", testTree.key)
        print("FINISHED WITHOUT ERRORS")
    }
}

