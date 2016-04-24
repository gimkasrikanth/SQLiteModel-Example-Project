//
//  ViewController.swift
//  tvOS+SQLiteModel
//
//  Created by Jeff Hurray on 4/24/16.
//  Copyright © 2016 jhurray. All rights reserved.
//

import UIKit
import SQLiteModel
import SQLite

class ViewController: UIViewController {

    var nodes: [Node] = []
    var n0: Node?
    var n1: Node?
    let nodeCount = 6
    
    let label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.frame = view.bounds
        label.font = UIFont.systemFontOfSize(48)
        label.textAlignment = .Center
        view.addSubview(label)
        
        label.text = "Loading Nodes from SQLite"
        
        createNodesWithCompletion {
            self.label.text = "There are \(self.nodes.count) nodes. There should be \(self.nodeCount) nodes"
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createNodesWithCompletion(completion: Void -> Void) {
        Node.newInBackground([Node.Name <- "my first node"]) { (node: Node?, error: SQLiteModelError?) -> Void in
            if let node = node {
                self.n0 = node
                self.nodes.append(node)
            }
            else {
                fatalError("Error: \(error)")
            }
            
            for index in 1..<self.nodeCount  {
                let node = try! Node.new([Node.Name <- "node.\(index)"], relationshipSetters: [Node.Children <- self.nodes])
                if index == 1 {
                    node <| Node.Parent |>  self.n0
                    self.n1 = node
                }
                if let lastNode = self.nodes.last {
                    node <| Node.Parent |> lastNode
                }
                self.nodes.append(node)
            }
            completion()
        }
    }

}

