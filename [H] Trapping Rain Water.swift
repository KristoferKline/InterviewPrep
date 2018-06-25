//
//  [H] Trapping Rain Water.swift
//  
//
//  Created by Kristofer Kline on 6/19/18.
//

import Foundation

class OptimizedSolution {
    func trap(_ height: [Int]) -> Int {
        var right = height.count - 1
        var left = 0
        var ans = 0
        
        // Sliding window
        while left < right {
            // Select starting point
            if (height[left] >= height[right]) {
                var i = right - 1
                // Traverse left until self or a lesser height is found
                while i > left && height[right] > height[i] {
                    // Add to the difference between
                    ans += height[right] - height[i]
                    i -= 1
                }
                right = i
            } else {
                var i = left + 1
                while i < right && height[left] > height[i] {
                    ans += height[left] - height[i]
                    i += 1
                }
                left = i
            }
        }
        
        return ans
    }
}
