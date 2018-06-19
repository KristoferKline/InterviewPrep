//
//  [M] Car Fleet.swift
//  852. Car Fleet: https://leetcode.com/problems/car-fleet/description/
//
//  Time Taken: 15 - 45 minutes (stopped for work)
//  Initial Thoughts:
//      - We can group the fleets based on what car they are going to run into.
//      - Iterating from the back to the front would be a pain.
//      - Checking through a chain in a fleet would be overly complicated.
//      - Definitely would make things easier to have things sorted.
//      - Rather than constantly indexing, we can increase readability by creating Fleet / Car models.
//
//  Side Notes:
//      - Realized I could handle the fleet in front by accessing the last element.
//      - That logic can be combined to initalize a new fleet if not found.
//      - If we did basic integer division, we could run into edge cases.
//      - Tempting to use `zip(_ sequence1: Sequence, _ sequence2: Sequence)` but that's not very performant (although it looks fantastic for readability).
//      - We can get some nice performance out of `Array.reserveCapacity(_ capacity: Int)` especially in smaller array instances where array will often have to resize.
//
//  Created by Kristofer Kline on 6/19/18.
//
//

import Foundation

class Solution {
    struct Car {
        let position: Int
        let timeLeft: Double
        
        init(position: Int, speed: Int, target: Int) {
            self.position = position
            timeLeft = (Double(target) - Double(position)) / Double(speed)
        }
    }
    
    func carFleet(_ target: Int, _ position: [Int], _ speed: [Int]) -> Int {
        var cars = [Car]()
        
        // Reserve the memory space and create car objects.
        cars.reserveCapacity(position.count)
        for i in 0 ..< position.count {
            cars.append(Car(position: position[i], speed: speed[i], target: target))
        }
        
        // Sort the cars with those closest to the finish first.
        let sorted = cars.sorted(by: { return $0.position > $1.position })
        
        // Iterate through the cars to find leaders.
        var leadCars = [Car]()
        for car in sorted {
            guard let fleetLeader = leadCars.last else {
                leadCars.append(car)
                continue
            }
            
            // If the car won't catch up to the fleet, seperate into own fleet.
            if fleetLeader.timeLeft < car.timeLeft {
                leadCars.append(car)
            }
        }
        
        return leadCars.count
    }
}
