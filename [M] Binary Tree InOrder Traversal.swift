//
//  [M] Binary Tree InOrder Traversal.swift
//  94. Binary Tree InOrder Traversal
//  https://leetcode.com/problems/binary-tree-inorder-traversal/description/
//
//  Description:
//  Given a binary tree, return the inorder traversal of its nodes' values.
//
//  Initial Thoughts:
//  - Looking at the return value of the initial function call, returning an [Int] would ruin our space complexity.
//  - This can be a little tricky, if we call from the node, it will end up not calling if nil.
//  - Why would we need to pass ourselves in a function? Perhaps it would be better to just have the node call the function.
//
//  Side Notes:
//  - This is a fun question to see if people understand optional chaining.
//      - i.e. If this was a function and we passed the root node (optional), the function would always have to check if the node is nil.
//      - Iff we call from the node object instead, it will automatically handle that for us because a nil object won't call a function if it doesn't exist.
//  - We can also use an inout reference rather than constantly returning an array to reduce our space complexity.
//
//  Optimizations:
//  - I don't know of any other ways besides using the inout reference and optional chaining to optimize the performance / space complexity.
//  - We know that it would take us O(n) because we need to visit every node.
//  - Base case of nil root node is also covered well because result is passed immediately after the method is called.
//  In long-term where we expect other cases to have an actual root node, adding a guard would be less performant.
//
//  Test Coverage:
//  - Base case: 1 (root) returns [1]
//  - Edge case: [nil, nil, nil] would still correctly return []
//
//  Created by Kristofer Kline on 6/25/18.
//

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
    func inorderTraversal(_ root: TreeNode?) -> [Int] {
        var result  = [Int]()
        root?.traverseInOrder(&result)
        return result
    }
}

extension TreeNode {
    func traverseInOrder(_ result: inout [Int]) {
        left?.traverseInOrder(&result)
        result.append(val)
        right?.traverseInOrder(&result)
    }
}
