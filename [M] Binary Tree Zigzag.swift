//
//  [M] Binary Tree Zigzag.swift
//  103. Binary Tree Zigzag Level Order Traversal
//  https://leetcode.com/problems/binary-tree-zigzag-level-order-traversal/description/
//
//  Initial Thoughts:
//  - Clearly a depth first search problem.
//  - Can recursively add the elements, appending or prepending depending on direction.
//
//  Side Notes:
//  - Ended up programming before having a solid strategy, solution was close to working with recursion but elements were slightly out of order at height > 2.
//  - Was initially thinking of using a stack for poping ability but realized queue would be same / better with the use of removeFirst()
//  - Using an extension allows us to use optional chaining to remove nils from the queue and avoid having to guard for removeFirst().
//  - Ended up removing direction enum after realizing I could use the level number being even / odd.
//
//  Created by Kristofer Kline on 6/25/18.
//

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
    func zigzagLevelOrder(_ root: TreeNode?) -> [[Int]] {
        var result = [[Int]]()
        var queue = [(node: TreeNode, level: Int)]()
        root?.add(toQueue: &queue, level: 0)
        
        while !queue.isEmpty {
            let item = queue.removeFirst()
            if result.count == item.level { result.append([Int]()) }
            (item.level % 2 == 0) ? result[item.level].append(item.node.val) : result[item.level].insert(item.node.val, at: 0)
            item.node.left?.add(toQueue: &queue, level: item.level + 1)
            item.node.right?.add(toQueue: &queue, level: item.level + 1)
        }
        
        return result
    }
}

extension TreeNode {
    func add(toQueue queue: inout [(node: TreeNode, level: Int)], level: Int) {
        queue.append((self, level))
    }
}
