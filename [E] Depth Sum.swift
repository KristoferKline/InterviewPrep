//
//  DepthSum-Easy.swift
//  
//
//  Created by Kristofer Kline on 6/14/18.
//

import Foundation

//
protocol NestedInteger {
    func isInteger() -> Bool
    func getInteger() -> Int
    func setInteger(value: Int)
    func add(elem: NestedInteger)
    func getList() -> [NestedInteger]
}

final class EasySolutions {
    /**
     LeetCode 339. Nested List Weight Sum: https://leetcode.com/problems/nested-list-weight-sum/description/
     
     Given a nested list of integers, return the sum of all integers in the list weighted by their depth.
     Each element is either an integer, or a list -- whose elements may also be integers or other lists.
     
     **Examples**:
     ```
     Given the list [[1,1],2,[1,1]], return 10. (four 1's at depth 2, one 2 at depth 1)
     Given the list [1,[4,[6]]], return 27. (one 1 at depth 1, one 4 at depth 2, and one 6 at depth 3; 1 + 4*2 + 6*3 = 27)
     ```
     
     - *Time taken*: 10-15 minutes.
     - *Possible Optimizations*: We can reduce space complexity by add an inout parameter for sum.
     */
    func depthSum(_ nestedList: [NestedInteger]) -> Int {
        return sumList(nestedList, depth: 1)
    }
    
    private func sumList(_ nestedList: [NestedInteger], depth: Int) -> Int {
        var sum = 0
        for element in nestedList {
            if element.isInteger() {
                sum += element.getInteger() * depth
            } else {
                sumList(element.getList(), depth: depth + 1)
            }
        }
        return sum
    }
    
}


