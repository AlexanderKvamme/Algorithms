//
//  StackViewController.swift
//  Algorithms
//
//  Created by Alexander Kvamme on 09/03/2017.
//  Copyright © 2017 Alexander Kvamme. All rights reserved.
//

import UIKit

class StackViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let node1 = StackNode<String>("bam")
        let node2 = StackNode<String>("bam bam")
        let node3 = StackNode<String>("bam bam bam")
        let node4 = StackNode<String>("bam bam bam bam")
        let node5 = StackNode<String>("bam bam bam bam bam")
        let node6 = StackNode<String>("bam bam bam bam bam bam")
        
        var nodes: [StackNode<String>] = [node1,node2,node3,node4,node5]
        
        var myStack  = Stack<String>(nil)
        
        for node in nodes{
            myStack.push(node)
        }

        print(myStack)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
