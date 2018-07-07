//
//  [E] Path Sum.swift
//  112. Path Sum
//  https://leetcode.com/problems/path-sum/description/
//
//  Description:
//  Given a binary tree and a sum, determine if the tree has a root-to-leaf path such that adding up all the values along the path equals the given sum.
//
//  Initial Thoughts:
//  - Pretty simple DFS problem.
//  - Inital steps were to create a brute force approach.
//  - Want to return true if any of the scenarios are met, false if none are found.
//  - Since this is a recursive solution, the branch reaching down to true to go faster than the false.
//
//  Side Notes:
//  - Wanted to make an extension to take advantage of optional chaining, ended up still having to default to a value.
//  - Still got a decent amount of performance out of the optimized solution.
//  - Comes from reordering the logic to check for initial met condition.
//  - If we know we're the root, it'll go faster.
//  - Ideally would like to place left?.isLeaf and right?.isLeaf first because those will be run more often.
//
//  Run-time:
//  - O(n) where n is the number of nodes
//
//  Created by Kristofer Kline on 7/2/18.
//

import Foundation

class OptimizedSolution {
    func hasPathSum(_ root: TreeNode?, _ sum: Int) -> Bool {
        return root?.isLeaf(of: sum) ?? false
    }
}

extension TreeNode {
    func isLeaf(of sum: Int) -> Bool {
        if left == nil && right == nil { return sum == val }
        let newSum = sum - val
        return (left?.isLeaf(of: newSum) ?? false) || (right?.isLeaf(of: newSum) ?? false)
    }
}

class SlowSolution {
    func hasPathSum(_ root: TreeNode?, _ sum: Int) -> Bool {
        guard root != nil else { return false }
        if root!.val == sum &&
            root!.left == nil &&
            root!.right == nil { return true }
        
        if hasPathSum(root!.left, sum - root!.val) { return true }
        if hasPathSum(root!.right, sum - root!.val) { return true }
        return false
    }
}
