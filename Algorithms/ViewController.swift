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
            //print("leftChildren of \(key) DIDSET: BalanceFactor now: ", balanceFactor)
            
            if abs(balanceFactor) >= 2{
                print("\(key) failed test with \(balanceFactor), sending to pivot\n")
                pivot(self)
            }
        }
    }
    var rightChildren = 0 {
        didSet {
            //print("rightChildren of \(key) DIDSET: BalanceFactor now: ", balanceFactor)
            
            if abs(balanceFactor) >= 2 {
                print("\(key) failed test with \(balanceFactor), sending to pivot\n")
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
        
        //har nå vært gjennom insert funksjonen, som itererer seg opp til rootnode, og kaller add() på denne.
        
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
        print("---")
        print("key: ", key)
        print("parent:", parent)
        
        if hasLeftChild {
         print("leftChild:", leftChild!.key)
        } else {print("leftChild: nil")}
        print("leftChildCount:" ,leftChildren)
        
        if hasRightChild{
        print("rightChild:", rightChild!.key)
        } else {print("rightChild: nil")}
        print("rightChildCount:" ,rightChildren)
        print("---")
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

//extension Node {
//    var balanceFactor: Int {
//        return rightChildren - leftChildren
//    }
//}

extension Node {
    var balanceFactor: Int {
        
        return rightHeight - leftHeight
        //return rightChild?.height - leftChild?.height
    }
}

// pivot functions

extension Node {
    func pivot(_ root: Node) {
        
        print("\n - now in pivot - ")
        root.printEntireTree()
        
        let rotationType = getRotationType(root)
        print("decided rotationtype: \(rotationType) on \(key)")
        
        switch rotationType{
        case .LL:
            print("ROTATING LL on ", root.key)
           rotateLL(root)
            
        case .LR:
            print("ROTATING LR on ", root.key)
            rotateLR(root)
            
        case .RR:
            print("ROTATING RR on ", root.key)
            rotateRR(root)
            
        case .RL:
            print("ROTATING RL on ", root.key)
            rotateRL(root)
            
        case .None:
            print("didnt find anything")
        }
        
        
        print("pivoting done")
        print()
        
    }
}

// AVL rotation functions

extension Node {
    func rotateLL(_ root: Node) {
        print("rotating root \(root.key) LL")
        print("root \(root.key) looks like this at start:")
        root.printInfo()
        root.printEntireTree()
        
//        let newRoot = root.leftChild!
//        
//        if root.hasParent {
//            newRoot.parent = root.parent
//            newRoot.parent?.leftChild = newRoot
//        } else {
//            newRoot.parent = nil
//        }
//        
//        newRoot.rightChild = root
//        newRoot.rightChildren = 1
//        
//        //root.rightChildren = 0
//        root.leftChild = nil
//        root.leftChildren = 0
//        root.parent = newRoot
        
        let rootTemp = Node(root.key)
        let pivotNode = root.leftChild
        let botNode = pivotNode?.leftChild
        
        // først koblinger, så children
        
        rootTemp.leftChild = root.leftChild
        rootTemp.parent = root.parent
        rootTemp.rightChild = root.rightChild
        
        root.key = pivotNode!.key
        
        root.leftChild = botNode
        root.leftChildren = 1
        botNode?.parent = root
        
        // ny
        root.rightChild?.leftChild = pivotNode?.rightChild
        
        root.rightChild = pivotNode
        root.rightChildren = 1
        pivotNode?.key = rootTemp.key
        
        botNode?.leftChildren = 1
        botNode?.rightChildren = 0
        //botNode?.leftChild = nil
        botNode?.rightChild = nil
    
        //root.rightChild?.rightChild = pivotNode?.
        root.rightChild?.leftChild = pivotNode?.rightChild
        root.rightChild?.rightChildren = 1
        root.rightChild?.leftChildren = 1
        root.rightChild?.rightChild = rootTemp.rightChild
        root.rightChild?.rightChild?.leftChild = nil
        
        //pivotNode?.leftChildren = 0
        //pivotNode?.rightChildren = 0
        //pivotNode?.leftChild = nil
        //pivotNode?.rightChild = nil
    
        
        // Test
        print("root \(root.key) looks like this in the end:")
        root.printInfo()
        root.printEntireTree()
    }
    
    func rotateLR(_ root: Node){
        print("rotating  \(key) LR")
        let pivotPoint = root.leftChild!
        let nodeToSwap = pivotPoint.rightChild!
        
        //pivotPoint.disconnect()
        //nodeToSwap.disconnect()
        
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
        
        print("rotating  \(key) RR")
//        print("rotateRR started")
//        let newRoot = root.rightChild!
//        
//        if root.hasParent{
//            newRoot.parent = root.parent
//            newRoot.parent?.rightChild = newRoot
//        } else {
//            newRoot.parent = nil
//        }
//        root.parent = newRoot
//        newRoot.leftChild = root
//        newRoot.leftChildren = 1
//        root.rightChild = nil
//        root.rightChildren = 0
//        print("rotateRR ended")

        // part deux
        
        let tempRoot = Node(root.key)
        let pivotNode = root.rightChild!
        let botNode = pivotNode.rightChild!
        
        tempRoot.parent = root.parent
        root.key = pivotNode.key
        
        pivotNode.disconnect()
        botNode.disconnect()
        
        root.leftChild = pivotNode
        pivotNode.key = tempRoot.key
        pivotNode.parent = root
        pivotNode.leftChildren = 0
        pivotNode.rightChildren = 0
        
        botNode.parent = root
        root.rightChild = botNode
        botNode.leftChildren = 0
        botNode.rightChildren = 0
        
        root.parent = tempRoot.parent
        root.leftChildren = 1
        root.rightChildren = 1
        
        
        
    }
    
    func rotateRL(_ root: Node){
        print("rotating \(key)  RL")
        
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
    case None
}

func getRotationType(_ node: Node) -> RotationType{
//    print("in getRotationType we are testing node:")
//    node.printInfo()
    if node.hasLeftChild {
        if node.leftChild!.hasLeftChild {
            return .LL
        }
        if node.leftChild!.hasRightChild {
            return .LR
        }
    }
    if node.hasRightChild {
            if node.rightChild!.hasRightChild {
                return .RR
            }
        if node.rightChild!.hasLeftChild {
            return .RL
        }
    }
    print("no rotation type found, returning None")
    return .None
}
extension Node {
    func disconnect() {
        parent = nil
        if hasLeftChild {leftChild = nil}
        if hasRightChild {rightChild = nil}
        print("\(key) disconnected from all parts")
    }
}

// MARK: - Height of rtee

extension Node{
    
    var leftHeight: Int {
        if hasNoLeftChild {
            return 0
        } else {
            return leftChild!.height + 1
        }
    }
    var rightHeight: Int {
        if hasNoRightChild {
            return 0
        } else {
            return rightChild!.height + 1
        }
    }
    
    var height: Int{
        if hasNoChildren{
            return 0
        }
        if hasBothChildren{
            if leftChild!.height > rightChild!.height{
                return leftChild!.height + 1
            } else {
                return rightChild!.height + 1
            }
        }
        if hasLeftChild{
            return leftChild!.height + 1
        }
        else {
            return rightChild!.height + 1
        }
    }
}


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var testTree = Node(2)
        testTree.insert(1)
        testTree.insert(3)
        testTree.insert(6)
        testTree.insert(15)
        testTree.printEntireTree()
        
        print("FINISHED WITHOUT ERRORS")
    }
}

