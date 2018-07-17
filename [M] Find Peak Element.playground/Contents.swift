/*
 [M] Find Peak Element.swift
 162. Find Peak Element
 Link: https://leetcode.com/problems/find-peak-element/
 
 Description:
 A peak element is an element that is greater than its neighbors.
 Given an input array nums, where nums[i] ≠ nums[i+1], find a peak element and return its index.
 The array may contain multiple peaks, in that case return the index to any one of the peaks is fine.
 You may imagine that nums[-1] = nums[n] = -∞.
 
 Initial Thoughts:
 - Didn't interpret the directions nums[i] ≠ nums[i+1] correctly.
    - This changes a lot of how the approach is done.
    - Makes a lot more sense how this can be done in log time given the rule forces the values are increasing or decreasing.
 - First approach was to iterate through the array and compare left/right.
 
 Optimizations:
 - Biggest key is knowing that items can only be increasing or decreasing.
 - Essentially a sliding window technique in which we slide in one way or the other and repeat.
 - Run time of cleaner solution is ~ O(logn)
*/

class CleanerSolution {
    func findPeakElement(_ nums: [Int]) -> Int {
        var left = 0, right = nums.count - 1
        while left < right {
            let mid = (left + right) / 2
            if nums[mid] < nums[mid + 1] {
                // Number is less than the number to the right.
                // Slide the window inwards from the left.
                left = mid + 1
            } else {
                // Number is greater than number to the right.
                // Slider the window inwards from the right.
                right = mid
            }
        }
        return left
    }
}

class Solution {
    func findPeakElement(_ nums: [Int]) -> Int {
        guard nums.count > 2 else {
            if nums.count == 1 {
                return 0
            } else {
                return nums[0] > nums[1] ? 0 : 1
            }
        }
        
        // Beginning.
        if nums[0] > nums[1] { return 0 }
        
        // Cover the middle sections.
        var previous = Int.min
        for i in 1 ..< nums.count - 1 {
            if nums[i] >= previous && nums[i] > nums[i + 1] {
                return i
            }
            previous = nums[i]
        }
        
        // End.
        return (nums[nums.count - 1] >= nums[nums.count - 2]) ? (nums.count - 1) : -1
    }
}

let testCase = [1,2,3,4,5,6,7,6,7,8,9,10,11,12,11]

Solution().findPeakElement(testCase)
CleanerSolution().findPeakElement(testCase)
Solution().findPeakElement(testCase.reversed())
CleanerSolution().findPeakElement(testCase.reversed())

