//
//  [M] Letter Combinations.swift
//  17. Letter Combinations of a Phone Number: https://leetcode.com/problems/letter-combinations-of-a-phone-number/
//
//  Initial Thoughts:
//      - Definitely involves embedded for loops to handle each additional number input.
//      - Definitely going to be an O(n^2) because we need to produce O(n^2) outputs.
//
//  Side Notes:
//      - In order for us to reference the next number's set, a recursive solution is needed.
//      - Ended up making the helper function an extension on string for code readability.
//
//  Performance: Top 98.26% of Swift submissions (12ms for 25 cases)
//      - 40% of submissions are in the 12ms bucket area, so nothing crazy going on.
//      - Most submissions are using a similar technique (including top performant)
//      - Appears other optimizations come from skipping or exiting early.
//      - Went from 16ms to 12ms by force casting lookup.
//
//
//
//  Created by Kristofer Kline on 6/20/18.
//

import Foundation

extension Array where Element == String {
    /**
     Expands the array to encompass all combinations with the provided strings.
     - parameter strings: Appended to the end of every element.
     */
    mutating func expand(with strings: [String]) {
        var result = [String]()
        forEach {
            for string in strings {
                result.append($0 + string)
            }
        }
        self = result
    }
}

class Solution {
    let dict: [Character: [String]] = [
        "2": ["a","b","c"],
        "3": ["d","e","f"],
        "4": ["g","h","i"],
        "5": ["j","k","l"],
        "6": ["m","n","o"],
        "7": ["p","q","r","s"],
        "8": ["t","u","v"],
        "9": ["w","x","y","z"]
    ]
    
    func letterCombinations(_ digits: String) -> [String] {
        // Convert the digits into corresponding possible characters.
        var input = [[String]]()
        for digit in digits {
            input.append(dict[digit]!)
        }
        
        // Quick check to make sure the input isn't too short.
        guard input.count > 1 else { return input.first ?? [] }
        
        var result = input[0]
        for i in 1 ..< input.count {
            result.expand(with: input[i])
        }
        
        return result
    }
}
