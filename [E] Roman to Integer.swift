//
//  RomanToInteger-Easy.swift
//  
//
//  Created by Kristofer Kline on 6/14/18.
//

import Foundation

final class Solution {
    private let romanValues: [Character: Int] = [
        "I": 1,
        "V": 5,
        "X": 10,
        "L": 50,
        "C": 100,
        "D": 500,
        "M": 1000
    ]
    
    /**
     Leetcode 17. Roman to Integer: https://leetcode.com/problems/roman-to-integer/description/
     Roman numerals are represented by seven different symbols: I, V, X, L, C, D and M.
     ```
     Symbol       Value
     I             1
     V             5
     X             10
     L             50
     C             100
     D             500
     M             1000
     ```
     For example, two is written as II in Roman numeral, just two one's added together. Twelve is written as, XII, which is simply X + II. The number twenty seven is written as XXVII, which is XX + V + II.
     
     Roman numerals are usually written largest to smallest from left to right. However, the numeral for four is not IIII. Instead, the number four is written as IV. Because the one is before the five we subtract it making four. The same principle applies to the number nine, which is written as IX. There are six instances where subtraction is used:
     
     I can be placed before V (5) and X (10) to make 4 and 9.
     X can be placed before L (50) and C (100) to make 40 and 90.
     C can be placed before D (500) and M (1000) to make 400 and 900.
     Given a roman numeral, convert it to an integer. Input is guaranteed to be within the range from 1 to 3999.
     
     - Edge case not covered: Multiple lower values before a greater value.
     - Time taken: 15-25 minutes.
     */
    func romanToInt(_ s: String) -> Int {
        // Initial check: String empty?
        guard !s.isEmpty else { return 0 }
        
        // Get the first value, if it fails, value is invalid.
        guard let firstValue = romanValues[s[s.startIndex]] else { return -1 }
        var value = firstValue
        var lookupValue = firstValue
        
        var currentIndex = s.index(after: s.startIndex)
        while currentIndex < s.endIndex {
            // For each characer, make sure it is found in our dictionary
            guard let lookup = romanValues[s[currentIndex]] else { return -1 }
            
            if lookup > lookupValue {
                guard lesserValueIsValid(old: lookupValue, new: lookup) else { return -1 }
                value -= 2 * lookupValue
            }
            
            lookupValue = lookup
            value += lookup
            
            currentIndex = s.index(after: currentIndex)
        }
        
        return value
    }
    
    /**
     Utility used to make sure the roman numeral before is a valid pairing.
     */
    func lesserValueIsValid(old: Int, new: Int) -> Bool {
        switch old {
        case 1: return new == 5 || new == 10
        case 10: return new == 50 || new == 100
        case 100: return new == 500 || new == 1000
        default: return false
        }
    }
}
