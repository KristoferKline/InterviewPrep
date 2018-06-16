//
//  BinaryTreeLevelOrderTraversal-Medium.swift
//  102. Binary Tree Level Order Traversal
//  Difficulty: Medium
//  Time Taken: 15 - 30 minutes (after watching video to find out what it is)
//
//  Side Notes:
//  - Off top of my head, didn't know how to traverse (similar to depth-first) and place into an array
//  - Videos generally suggest adding elements to a queue and then popping them after being visited.
//  - Realized I could essentially use the depth to initialize levels of the array instead of getting the length
//  - Thought it would be cooler to do using a dispatch queue synchronized for concurent actions.
//  - Leetcode doesn't automatically `import Foundation` so this solution won't work on their site.
//  - In all fairness, even command-line scripts can `import Foundation`
//
//  Created by Kristofer Kline on 6/16/18.
//  Given a binary tree, return the level order traversal of its nodes' values. (ie, from left to right, level by level).

import Foundation

class Node<T: Comparable> {
    var value: T
    var left: Node<T>?
    var right: Node<T>?
    
    init(_ value: T) {
        self.value = value
    }
}

extension Node {
    func traverse(addTo result: inout [[Character]], on queue: DispatchQueue, depth: Int) {
        if depth >= result.count { result.append([Character]())}
        result[depth].append(value)
        queue.sync {
            self.left?.traverse(addTo: &result, on: queue, depth: depth + 1)
            self.right?.traverse(addTo: &result, on: queue, depth: depth + 1)
        }
    }
}

class Solution {
    let root: Node<Character>
    var result = [[Character]]()
    let queue: DispatchQueue
    
    init(qos: DispatchQoS) {
        queue = DispatchQueue(label: "level order", qos: qos, attributes: .concurrent)
        
        root = Node("A")
        let nodeB = Node("B")
        let nodeC = Node("C")
        nodeB.left = Node("D")
        nodeC.left = Node("E")
        nodeC.right = Node("F")
        root.left = nodeB
        root.right = nodeC
        
        /*
         Right
         /----[F]
         /----[C]
         |       \----[E]
         [A]
         |
         \----[B]
         \----[D]
         Left
         */
    }
    
    func solve() -> [[Character]] {
        root.traverse(addTo: &result, on: queue, depth: 0)
        return result
    }
}
