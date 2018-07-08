//
//  [M] Permutations.swift
//  
//
//  Created by Kristofer Kline on 7/7/18.
//

import Foundation

class Solution {
    func permute(_ nums: [Int]) -> [[Int]] {
        var result = [[Int]]()
        var mutable = nums
        mutable.heapPermutate(nums.count, result: &result)
        return result
    }
}

extension Array where Element == Int {
    mutating func heapPermutate(_ size: Int, result: inout [[Int]]) {
        guard size != 1 else { return result.append(self) }
        for i in 0 ..< size {
            self.heapPermutate(size - 1, result: &result)
            if size % 2 == 0 {
                // i is even: swap ith and last
                swapAt(i, size - 1)
            } else {
                // i is odd: Swap first and last
                swapAt(0, size - 1)
            }
        }
    }
}

class OptimizedSolution {
    func permute(_ nums: [Int]) -> [[Int]] {
        guard nums.count > 1 else {
            print("Returning: \(nums)")
            return [nums]
        }
        
        let leftOver = Array(nums[1...])
        let lOPerms = permute(leftOver)
        
        var res = [[Int]]()
        for lO in lOPerms {
            for i in 0 ... lO.count {
                var r = lO
                r.insert(nums[0], at: i)
                res.append(r)
            }
        }
        return res
    }
}

