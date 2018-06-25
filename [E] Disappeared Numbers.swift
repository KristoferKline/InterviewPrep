//
//  [E] Disappeared Numbers.swift
//  448. Find All Numbers Disappeared in an Array
//  https://leetcode.com/problems/find-all-numbers-disappeared-in-an-array/
//
//  Initial Thoughts:
//  - Super simple kind of problem, can result in very interesting optimizations.
//  - Can easily do it with a set and simply remove elements and return the set as an array.
//  - Somewhat ideal solution given the simplicity but immediately we can see that this requires 2 * 0(n).
//
//  Side Notes:
//  - Went with the initial approach because it felt more efficient to evaluate other solutions and try optimize those.
//  - We know that it would take us O(n) because we have to read through all the elements to see which elements exist.
//  - Weird thought, we could technically perform in less than O(n) given that we know the range but the overhead for checking ranges would likely perform significantly slower.
//  - The optimized performance is faster than remove because remove also checks to see if the element exists in the set.
//  - This is somewhat confusing because it feels like the set would produce less operations but set appears to have more going on behind the scenes.
//      - Looking at the implementation of set, we can also see that remove requires an additional functional call which calls to it's variable buffer to remove the element.
//      - Buffer in this scenario being a data buffer (memory allocation).
//      - Unfortunately the _NativeBuffer type is hard to research, there are very few mentions of it on the internet.
//
//  Created by Kristofer Kline on 6/23/18.
//

import Foundation

class OptimizedSolution {
    // NOTE: This solution comes from the top of SwiftLeetcode which I then optimized a little more.
    // Took 84 ms for 34 test cases.
    func findDisappearedNumbers(_ nums: [Int]) -> [Int] {
        // nums range: { 1 ... nums.count }
        // Adding an additional element so less operations are performed for mapping index to value.
        var present = [Bool](repeating: false, count: nums.count + 1)
        for i in 0 ..< nums.count {
            // Previous fastest version would do nums[i] - 1
            // This is solution requires n operations less.
            present[nums[i]] = true
        }
        
        var missing = [Int]()
        for i in 1 ..< present.count {
            if present[i] == false {
                // To adjust for the offset previously, other fastest solution would also add 1 here.
                // Another optimization of n operations.
                missing.append(i)
            }
        }
        return missing
    }
}

class BruteSolution {
    // This solution takes longer (272 ms for the same 34 test cases)
    func findDisappearedNumbers(_ nums: [Int]) -> [Int] {
        // Due to turning the elements into a set.
        var missing = Set(nums)
        nums.forEach {
            // Here's where the optimization happens.
            // This is also a discardable result so it returns the value if did exist.
            missingNums.remove($0)
        }
        return Array(missing)
    }
}

