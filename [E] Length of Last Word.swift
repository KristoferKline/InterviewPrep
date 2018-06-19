//
//  LengthOfLastWord-Easy.swift
//  Simple warm up exercise.
//  Time: 10 minutes
//
//  Side Notes:
//  - This assumes we are counting all characters as words.
//  - Alternative would be a simple hash set lookup of the character.
//  - This is a pretty friendly approach because reversed() is able to reverse the string in O(1) and essentially just remaps indexing to the reverse order.

//  - Edge Cases:
//      - 'a   '
//          - Checking for the first space character will return early if you don't also check the count.
//
//  Created by Kristofer Kline on 6/17/18.
//

import Foundation

class Solution {
    func lengthOfLastWord(_ s: String) -> Int {
        var count = 0
        for char in s.reversed() {
            if char == " " {
                if count > 0 { return count }
            } else {
                count += 1
            }
        }
        return count
    }
}
