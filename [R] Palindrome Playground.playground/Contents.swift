import Foundation
import XCTest

let string = "AAAA AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"
let string2 = "BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB"
let string3 = "CCCCCCCCCCCCCCC CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC"
let string4 = "DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD DDDDDDDDDDDDDDDDD"
let string5 = "EEEEEEEEEEEEEEEEEEEEEEEEEEEEEE EEEEEEEEEEEEEEEEEEEEEEEEEEE"

// Fun 1-liner.
func isPalindrome(_ s: String) -> Bool {
    return s.elementsEqual(s.reversed())
}

// Using indices.
func isPalindrome2(_ s: String) -> Bool {
    var leftIndex = s.startIndex
    var rightIndex = s.index(before: s.endIndex)
    
    while leftIndex <= rightIndex {
        guard s[leftIndex] == s[rightIndex] else { return false }
        leftIndex = s.index(after: leftIndex)
        rightIndex = s.index(before: rightIndex)
    }
    
    return true
}

// Using iterators.
func isPalindrome3(_ s: String) -> Bool {
    var reverseIterator = s.reversed().makeIterator()
    var iterator = string.makeIterator()
    for _ in 0 ... string.count / 2 {
        guard reverseIterator.next() == iterator.next() else { return false }
    }
    return true
}

isPalindrome(string)

class MyTestCase: XCTestCase {
    func testSpeed() {
        measure {
            for _ in 0 ..< 25 {
                let _ = isPalindrome2(string)
                let _ = isPalindrome2(string2)
                let _ = isPalindrome2(string3)
                let _ = isPalindrome2(string4)
                let _ = isPalindrome2(string5)
            }
        }
    }
    
    func testSpeed2() {
        measure {
            for _ in 0 ..< 25 {
                let _ = isPalindrome2(string)
                let _ = isPalindrome2(string2)
                let _ = isPalindrome2(string3)
                let _ = isPalindrome2(string4)
                let _ = isPalindrome2(string5)
            }
        }
    }
    
    func testSpeed3() {
        measure {
            for _ in 0 ..< 25 {
                let _ = isPalindrome2(string)
                let _ = isPalindrome2(string2)
                let _ = isPalindrome2(string3)
                let _ = isPalindrome2(string4)
                let _ = isPalindrome2(string5)
            }
        }
    }
}

MyTestCase.defaultTestSuite.run()
