//
//  [M] Maximal Square.swift
//  221. Maximal Square
//
//
//  Created by Kristofer Kline on 7/17/18.
//
/*
 [M] Maximal Square.swift
 221. Maximal Square
 Link: https://leetcode.com/problems/maximal-square/
 
 Description:
 Given a 2D binary matrix filled with 0's and 1's, find the largest square containing only 1's and return its area.
 
 Input:
 1 0 1 0 0
 1 0 1 1 1
 1 1 1 1 1
 1 0 0 1 0
 
 Output: 4
 
 Initial Thoughts:
 - Going to need to try and use some sort of storage in order to not recompute a lot of the values.
 - Can potentially use an XOR of the neighbor values to identify if they are all the same and then add 1 to one of the neighbors for the updated value.
 - Going to perform a double for loop (for row and column) but need to check for bounds.
    - Works out well because those edges don't need to calculate neighbor value.
 - The input is a 2D array of characters, they need to be converted to integers before.
 - Can a 2D array be casted as another 2D array? (No)
 
 Optimizations:
 - Can actually just iterate through and append elements while performing the checks rather than converting first.
 - This is also going off the assumption that the input is a perfect square of n x m.
 - Ended up not using XOR because that does not cover cases where neighbors share a common size of x.
 - Run time is O(n) reduced where n is the rows x columns.
 - Space complexity is O(n) because we are storing previous results to be referenced later on.
*/

import Foundation

class Solution {
    func maximalSquare(_ matrix: [[Character]]) -> Int {
        var result = 0
        var storage = [[Int]]()
        for row in 0 ..< matrix.count {
            storage.append([Int]())
            for column in 0 ..< matrix[row].count {
                // Continue to the next index if in the first row/column or value is a 0
                guard row > 0, column > 0, matrix[row][column] == "1" else {
                    storage[row].append(matrix[row][column] == "1" ? 1 : 0)
                    if storage[row][column] > result { result = 1 }
                    continue
                }
                
                // Otherwise find the neighborhood size.
                storage[row].append(neighborhoodSize(storage,
                                                     row: row,
                                                     column: column))
                
                // If result is larger than previous, place new highest.
                if storage[row][column] > result {
                    result = storage[row][column]
                }
            }
        }
        return result * result
    }
    
    private func neighborhoodSize(_ matrix: [[Int]], row: Int, column: Int) -> Int {
        return min(matrix[row][column-1],
                   matrix[row-1][column],
                   matrix[row-1][column-1]) + 1
    }
}
