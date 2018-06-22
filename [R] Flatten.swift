//
//  [R] Flatten.swift
//  R being random curiousity challenge.
//
//  Motivation:
//      - Coworker was talking about using the joined() method on an array to reduce a double nested array.
//      - I usually use flatMap and looked into how joined() and flatMap() both only go one layer deep.
//      - That makes sense given that unwrapping all the way would lead to people accidentally reducing to 1D.
//
//  Observations:
//      - Using an inout parameter and helper method over mutating function for memory usage & simplicity.
//      - Run Time: We have (reduced) O(n) where n is the number of elements in the final 1D array.
//      - Memory: Using O(n) since everything is being placed into the array.
//      - Function stack grows pretty large depending on the number of elments / nested arrays due to the recursive helper calls.
//      - Inside the helper switch statement, casting as the generic Array type will fail, must use Array<Any> for nested ararys.
//      - Using Array.append(contentsOf: Element.Type) provides a nice optimization of around (30-40%) with the given test example array.
//
//
//  Created by Kristofer Kline on 6/22/18.
//

import Foundation

extension Array {
    /**
     Flattens an array containing nested arrays into a 1D array of specified type.
     - parameter toType: The desired element type, only elements of the specified type will be added to the result array.
     - returns: 1D array of specified type. If there are no elements of the specified type found, an empty array will be returned.
     */
    func flatten<T>(toType: T.Type) -> [T] {
        var result = [T]()
        flattenHelper(&result)
        return result
    }
    
    private func flattenHelper<T>(_ result: inout Array<T>) {
        forEach { (element) in
            switch element {
            case let element as Array<T>:
                result.append(contentsOf: element)
            case let element as Array<Any>:
                element.flattenHelper(&result)
            case let element as T:
                result.append(element)
            default:
                return
            }
        }
    }
}

// Nested array test source.
let source = [
    [[1],[2],[3],[4]],
    [[5],[6],[7],[8]],
    [[9],[10],[11],[12]],
    [[13,14],[15,16],[17,18],[19,20]],
    [[21,22],[23,24],[25,26],[27,28]],
    [[29,30],[31,32],[33,34],[35,36]],
    [[37,38],[39,40],[41,42],[43,44]],
    [[45,46],[47,48],[49,50],[51,52]],
    [[53,54,55],[56,57,58],[59,60,61],[62,63,64]],
    [[65],[66],[67]],[[68],[69],[70]],[[71],[72],[73]],[[74],[75],[76]],
    [[77],[78],[79]],[[80],[81],[82]],[[83],[84],[85]],[[86],[87],[88]],
    [[89,90],[91,92],[93,94]],[[95,96],[97,98],[99,100]]
]

// Example Usage.
let result = source.flatten(toType: Int.self)
