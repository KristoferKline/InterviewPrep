//
//  Medium - Queue Reconstruction by Height.swift
//
//  Time: DNF, looked online at implementations.
//  Side Notes:
//  - Noticed correctly that it is important to sort based on the height from largest to shortest.
//  - Experimented with different implementations of struct vs class (made no noticeable difference)
//  - This is done assuming the input source only contains a valid solution.
//  - The optimized solution is signficantly faster (2x) due to indexing.
//      - Despite force casting, using first / last has overhead:
//
//       public var first: Element? {
//          @inline(__always)
//          get {
//             // NB: Accessing `startIndex` may not be O(1) for some lazy collections,
//             // so instead of testing `isEmpty` and then returning the first element,
//             // we'll just rely on the fact that the iterator always yields the
//             // first element first.
//                var i = makeIterator()
//            return i.next()
//            }
//        }
//
//
//  Created by Kristofer Kline on 6/18/18.
//
//

import Foundation

class OptimizedSolution {
    func reconstructQueue(_ people: [[Int]]) -> [[Int]] {
        // Sort by height and then by number of individuals taller than.
        let sorted = people.sorted { (a, b) in
            return a[0] > b[0] || (a[0] == b[0] && a[1] < b[1])
        }
        
        // Go through the sorted list, adding them relative to the number of people taller than them.
        var result = [[Int]]()
        for person in sorted {
            result.insert([person[0], person[1]], at: person[1])
        }
        return result
    }
}

class Solution {
    func reconstructQueue(_ people: [[Int]]) -> [[Int]] {
        // Sort by height and then by number of individuals taller than.
        let sorted = people.sorted { (a, b) in
            return a.first! > b.first! || (a.first! == b.first! && a.last! < b.last!)
        }
        
        // Go through the sorted list, adding them relative to the number of people taller than them.
        var result = [[Int]]()
        for person in sorted {
            result.insert(person, at: person.last!)
        }
        return result
    }
}
