//
//  [M] Power.swift
//  50. Pow(x,n): https://leetcode.com/problems/powx-n/description/
//
//  Initial Thoughts:
//      - Did not think of crazy high power numbers at first.
//      - Conceptually a very simple question, optimizing is the bigger challenge.
//      - Starting off with brute force, we will perform in O(n).
//          - Internet says it can be faster :D
//
//  Side Notes:
//      - Looking at the brute force, our bottleneck is the power.
//      - Can use exponentiation by squaring (squaring our exponent until we are at the desired power value)
//      - The speed is significantly faster, definitely still not O(1), more of an O(logn).
//      - Optimized even more by doing several checks in the initial call and then handling the majority of the work in a helper function.
//
//  Created by Kristofer Kline on 6/21/18.
//

import Foundation

// Same solution as FastSolution but optimized.
class OptimizedSolution {
    func myPow(_ x: Double, _ n: Int) -> Double {
        guard n != 0 else { return 1 }
        guard x != 1 else { return 1 }
        guard x != -1 else { return n % 2 == 0 ? 1 : -1 }
        
        return n < 0 ? 1 / helper(x, n) : helper(x, n)
    }
    
    func helper(_ x: Double, _ n: Int) -> Double {
        guard n > 1 else { return x }
        return helper(x * x, n / 2) * ((n % 2 == 0) ? 1 : x)
    }
}

// Solution that won't time out.
class FastSolution {
    func myPow(_ x: Double, _ n: Int) -> Double {
        switch n {
        case let greater where n > 1 :
            if greater % 2 == 0 {
                return myPow(x * x, greater / 2)
            } else {
                return x * myPow(x * x, (greater - 1) / 2)
            }
        case let less where n < 0 :
            return myPow(1 / x, -less)
        case 1:
            return x
        case 0:
            return 1
        default: fatalError()
        }
    }
}

// Slowest solution, brute force that will time out over larger n values.
class Solution {
    func myPow(_ x: Double, _ n: Int) -> Double {
        guard x != 0 else { return 0 }
        guard n != 0 else { return 1 }
        return (n > 0) ? x.power(n) : (1 / x.power(-n))
    }
}

extension Double {
    func power(_ n: Int) -> Double {
        var result = self
        for _ in 1 ..< n {
            result *= self
        }
        
        return result
    }
}

