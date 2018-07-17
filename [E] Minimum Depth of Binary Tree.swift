/*
 [E] Minimum Depth of Binary Tree.swift
 111. Minimum Depth of Binary Tree
 Link: https://leetcode.com/problems/minimum-depth-of-binary-tree/
 
 Description:
 Given a binary tree, find its minimum depth.
 The minimum depth is the number of nodes along the shortest path from the root node down to the nearest leaf node.
 Note: A leaf is a node with no children.
 
 Initial Thoughts:
 - Looks like a good match for breadth first search.
 - If I reach a result of a tree through depth first, I have to check with other depths to verify.
    - Which would then result in having read all nodes.
 - Alternatively, just look for a node with no children and return it's depth.
 
 Optimizations:
 - The Solution feels like it should be more performant than the FastestSolution because FastestSolution relies on recursively calling the children which will then go through all the depths.
 - Run-time is O(n) in the scenario that the leaf is present 1 level above the lowest level on the very right.
    - Best case is O(1), average case is O(n/2).
 - Still need to investigate into FasterSolution, given that it should also be O(n).
*/

import Foundation

/**
 * Definition for a binary tree node.
 * public class TreeNode {
 *     public var val: Int
 *     public var left: TreeNode?
 *     public var right: TreeNode?
 *     public init(_ val: Int) {
 *         self.val = val
 *         self.left = nil
 *         self.right = nil
 *     }
 * }
 */
class Solution {
    func minDepth(_ root: TreeNode?) -> Int {
        var queue = [(TreeNode, Int)]()
        
        // If the root is not nil, add it to the queue.
        if let root = root {
            queue.append((root, 1))
        }
        
        while !queue.isEmpty {
            // Get the next item in the queue.
            let node = queue.removeFirst()
            // If it has no children, return the depth.
            if node.0.left == nil && node.0.right == nil { return node.1 }
            
            // Otherwise add its children.
            if let leftNode = node.0.left {
                queue.append((leftNode, node.1 + 1))
            }
            
            if let rightNode = node.0.right {
                queue.append((rightNode, node.1 + 1))
            }
        }
        
        // If the queue is empty, this will be reached and return 0.
        return 0
    }
}

class FastestSolution {
    func minDepth(_ root: TreeNode?) -> Int {
        return helperForDeepFisrt(root)
    }
    
    func helperForDeepFisrt(_ node: TreeNode?) -> Int {
        if node == nil {
            return 0
        }
        let leftInt = helperForDeepFisrt(node?.left)
        let rightInt = helperForDeepFisrt(node?.right)
        if leftInt != 0 && rightInt != 0 {
            return 1 + min(leftInt, rightInt)
        }
        return 1 + leftInt + rightInt
    }
}
