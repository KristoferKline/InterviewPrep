//
//  [M] Single Number III.swift
//  260. Single Number III
//  https://leetcode.com/problems/single-number-iii/
//
//  Description:
//  Given an array of numbers nums, in which exactly two elements appear only once and all the other elements appear exactly twice. Find the two elements that appear only once.
//
//  Initial Thoughts:
//  - I need to read through the entire input in order to correctly check for duplicates.
//  - Pretty simple solution, need to iterate through set and add or remove if they exist.
//
//  Side Notes:
//  - There is a faster solution based on XOR modification, weird trade-off for readability.
//
//  Created by Kristofer Kline on 6/27/18.
//

import Foundation

class Solution {
    func singleNumber(_ nums: [Int]) -> [Int] {
        var result = Set<Int>()
        nums.forEach {
            if result.contains($0) {
                result.remove($0)
            } else {
                result.insert($0)
            }
        }
        return [Int](result)
    }
}
