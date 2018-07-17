/*
 [H] Merge of Two Sorted Arrays
 4. Median of Two Sorted Arrays
 Link: https://leetcode.com/problems/median-of-two-sorted-arrays/
 
 Description:
 There are two sorted arrays nums1 and nums2 of size m and n respectively.
 Find the median of the two sorted arrays. The overall run time complexity should be O(log (m+n)).
 
 Initial Thoughts:
 - Start off with brute force:
    - Combine the two arrays and then sort with default sort function.
    - Return median of sorted combined array.
 - Median is pretty simple function, ran some sample tests to validate and looks like leetcode is looking for default median (includes duplicated numbers)
 
 Optimizations:
 - Obviously simply appending the elements and sorting isn't the best solution.
    - Would take O(n + m) to create array and then O(n+mlog(m+n)) to sort.
 - Made a simple merge sorted arrays function that adds elements until there are none left in the one of the arrays.
    - Conveniently we can use indices (int) of an array to iterate through and compare the two.
    - After one of the array runs out of elements to add, we append the remaining elements of the other:
        - Instead of doing if statements, just add an empty array.
 - End result is in O(n + m), could be improved by creating a better merge sorted arrays method.
*/

class Solution {
    func findMedianSortedArrays(_ nums1: [Int], _ nums2: [Int]) -> Double {
        let combined = mergeSorted(nums1, nums2)
        
        if combined.count % 2 == 0 {
            // The array has an even count, two middle elements need to be combined.
            let mid = combined.count / 2
            let average = Double(combined[mid] + combined[mid - 1]) / 2
            return average
        } else {
            // The array has an odd count, the integer is reduced to floor value.
            return Double(combined[(combined.count / 2)])
        }
    }
    
    private func mergeSorted(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
        guard !nums1.isEmpty && !nums2.isEmpty else { return nums1.isEmpty ? nums1 : nums2}
        var result = [Int]()
        result.reserveCapacity(nums1.count + nums2.count)
        
        var leftIndex = nums1.startIndex
        var rightIndex = nums2.startIndex
        
        while leftIndex < nums1.endIndex && rightIndex < nums2.endIndex {
            if nums1[leftIndex] <= nums2[rightIndex] {
                result.append(nums1[leftIndex])
                leftIndex += 1
            } else {
                result.append(nums2[rightIndex])
                rightIndex += 1
            }
        }
        
        result.append(contentsOf: nums1[leftIndex...])
        result.append(contentsOf: nums2[rightIndex...])
        
        return result
    }
}

import XCTest

final class MedianTests: XCTestCase {
    let sampleInputs = [
        [1],
        [2,3,4,5],
        [1,2,3,4,6,10,12],
        [13,21,42,4,6,10,12],
        [12,16,22,24,26,29,35,38,42,44,52,58],
        [1,3,4,6,7,9,10,12,45,46,47,50,53,54,55,56,83,83,84,85,95,94,102,113]
    ]
    
    func testMedian() {
        measure {
            for i in sampleInputs {
                for j in sampleInputs {
                    Solution().findMedianSortedArrays(i, j)
                }
            }
        }
    }
}

MedianTests.defaultTestSuite.run()


