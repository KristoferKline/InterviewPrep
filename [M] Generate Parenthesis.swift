//
//  [M] Generate Parenthesis.swift
//  22. Generate Parenthesis
//  https://leetcode.com/problems/generate-parentheses/
//
//  Description:
//  Given n pairs of parentheses, write a function to generate all combinations of well-formed parentheses.
//
//  Initial Thoughts:
//  - This is definitely a recrusive function problem.
//  - Don't immediately see the result, plotted out n = 0, n = 1, n = 2
//  - There is no immediate expansion pattern in which we use the elements are append to each.
//  - More of a branching out problem.
//
//  Side Notes:
//  - Reviewed a couple python solutons before creating the first genereateHelper solution.
//  - This is a harder problem to evaluate run-time.
//  - After looking at several test cases, it looks like the run time is around O(3^n)
//
//  Optimizations:
//  - Analyzing the first versus second generate approach.
//  - Interesting comparrison, the second generate solution is said to be faster but realistically as N approaches infinity, it quickly falls behind.
//  - This is due to running many more instances in which the last characters to be added are closed parenthesis.
//  - Running from N = 1 -> N = 8, we can see the first solution is actually 59.98% faster :)
//
//  Created by Kristofer Kline on 7/1/18.
//

class Solution {
    func generateParenthesis(_ n: Int) -> [String] {
        guard n > 1 else { return n > 0 ? ["()"] : [] }
        
        var result = [String]()
        generateHelper("(",
                       open: n - 1,
                       closed: 1,
                       result: &result)
        return result
    }
    
    func generater(_ n: Int) -> [String] {
        var result = [String]()
        generate(open: n, close: n, current: "", result: &result)
        return result
    }
    
    private func generateHelper(_ string: String,
                                open: Int,
                                closed: Int,
                                result: inout [String]) {
        // If we have no parenthesis to open, go ahead and close out the remaining.
        guard open > 0 else {
            return result.append(string + String(repeating: ")", count: closed))
        }
        
        // Reaching this point indicates we have more to open.
        // Add an opener and account for it needing to be closed by incrementing closed.
        guard closed > 0 else {
            return generateHelper(string + "(",
                                  open: open - 1,
                                  closed: closed + 1,
                                  result: &result)
        }
        
        // Otherwise explore both opening and closing options.
        generateHelper(string + "(",
                       open: open - 1,
                       closed: closed + 1,
                       result: &result)
        
        generateHelper(string + ")",
                       open: open,
                       closed: closed - 1,
                       result: &result)
        
    }
    
    // This is a faster solution than mine according to leetcode.
    // Tests say otherwise :D
    private func generate(open: Int, close: Int, current: String, result: inout [String]) {
        guard close != 0 else {
            result.append(current)
            return
        }
        
        if open < close {
            generate(open: open,
                     close: close-1,
                     current: current + ")",
                     result: &result )
        }
        
        if open > 0 {
            generate(open: open-1,
                     close: close,
                     current: current + "(",
                     result: &result )
        }
    }
}

import XCTest

class MyTests: XCTestCase {
    func testGenerate() {
        measure {
            Solution().generater(1)
            Solution().generater(2)
            Solution().generater(3)
            Solution().generater(4)
            Solution().generater(5)
            Solution().generater(6)
            Solution().generater(7)
        }
    }
    
    func testGenerateParenthesis() {
        measure {
            Solution().generateParenthesis(1)
            Solution().generateParenthesis(2)
            Solution().generateParenthesis(3)
            Solution().generateParenthesis(4)
            Solution().generateParenthesis(5)
            Solution().generateParenthesis(6)
            Solution().generateParenthesis(7)
        }
    }
}

MyTests.defaultTestSuite.run()
