/*
 [M] Course Scheduler.swift
 207. Course Schedule
 Link: https://leetcode.com/problems/course-schedule/
 
 Description:
 There are a total of n courses you have to take, labeled from 0 to n-1.
 
 Some courses may have prerequisites, for example to take course 0 you have to first take course 1, which is expressed as a pair: [0,1]
 
 Given the total number of courses and a list of prerequisite pairs, is it possible for you to finish all courses?
 
 Initial Thoughts:
 - I don't have a strong idea on how to handle this problem.
 - Perhaps a decent way of creating the graph is to create a dictionary of nodes to their dependencies.
 - After researching, found out that it's called an Adjacency List.
 - Looked for online solutions and modified existing code online, this is a DFS / BFS problem in which we are trying to identify reference cycles.
 - Secondary, we are trying to make sure we can complete the courses in time.
 
 After Thoughts:
 - This solution introduced the concept of indegree nodes to me: The list of nodes pointing to a specified node.
 - This can be done either through depth first / breadth first with a queue / stack.
    - Bother ways don't have much variation given that the priority is to iterate through all the nodes checking children.
 
 Optimizations:
 - In addition to building a graph, we can get a faster run-time by creating an inverse of the graph that shows inDegrees.
    - Alternatively, this will increase our space-complexity (doubled)
 - Other solutions often try and iterate through an entire graph to identify nodes that contain x as a dependency, using an inverse graph definitely does this faster.
 - This is a pretty solution when we have items with reference cycles.
    - If it's all reference cycles, then the queue will be empty and we skip straight to the end.
 - Tried using a counter instead of inverseGraph for the faster solution and it is slightly faster.
    - This makes sense since we are performing the same operations but requires less changese to memory.
    - Rather than reading from sets and looking up, we are simply indexing from an array.
 
 Created by Kristofer Kline on 7/18/18.
*/


import Foundation

class FasterSolution {
    func canFinish(_ numCourses: Int, _ prerequisites: [[Int]]) -> Bool {
        // Graph represents the dependencies each course has.
        var graph = [Set<Int>](repeating: Set<Int>(), count: numCourses)
        var indegrees = [Int](repeating: 0, count: numCourses)
        
        // Build The graph dependencies.
        for course in prerequisites {
            graph[course[0]].insert(course[1])
            indegrees[course[1]] += 1
        }
        
        // Add the independent courses to the stack.
        var queue = [Int]()
        for course in 0 ..< numCourses {
            if indegrees[course] == 0 {
                queue.append(course)
            }
        }
        
        var reqCount = 0
        while !queue.isEmpty {
            // Pull courses from the queue, incrementing how many requirements there are.
            let node = queue.removeFirst()
            reqCount += 1
            
            for course in graph[node] {
                indegrees[course] -= 1
                if indegrees[course] == 0 {
                    queue.append(course)
                }
            }
        }
        
        // If reqCount <, we have a reference cycle.
        // If reqCount >, the courses cannot be completed in time.
        return numCourses == reqCount
    }
}

class Solution {
    func canFinish(_ numCourses: Int, _ prerequisites: [[Int]]) -> Bool {
        // Graph represents the dependencies each course has.
        var graph = [Set<Int>](repeating: Set<Int>(), count: numCourses)
        // Inverse represents what courses are dependant on.
        var inverseGraph = [Set<Int>](repeating: Set<Int>(), count: numCourses)
        
        // Build The graph dependencies.
        for course in prerequisites {
            graph[course[0]].insert(course[1])
            inverseGraph[course[1]].insert(course[0])
        }
        
        // Add the independent courses to the stack.
        var queue = [Int]()
        for course in 0 ..< numCourses {
            if graph[course].isEmpty {
                queue.append(course)
            }
        }
        
        var reqCount = 0
        while !queue.isEmpty {
            // Pull courses from the queue, incrementing how many requirements there are.
            let node = queue.removeFirst()
            reqCount += 1
            
            // Now that the dependency is covered, remove it from courses that are dependent on it.
            for course in inverseGraph[node] {
                graph[course].remove(node)
                // If it has no more dependencies, add it to the queue.
                if graph[course].isEmpty {
                    queue.append(course)
                }
            }
        }
        
        // If reqCount <, we have a reference cycle.
        // If reqCount >, the courses cannot be completed in time.
        return numCourses == reqCount
    }
}
